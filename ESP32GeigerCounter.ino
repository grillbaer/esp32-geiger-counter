#include "Arduino.h"
#include "U8g2lib.h"

#include "driver/pcnt.h"
#include "driver/gpio.h"
#include "driver/rtc_io.h"

#include "GeigerData.h"

// ~400µs high pulses from Geiger tube on GPIO 18
#define PULSE_PIN 18
#define PULSE_GPIO GPIO_NUM_18

// OLED display 128x64 with SH1106 controller
// on I2C GPIOs SCL 22 and SDA 21
U8G2_SH1106_128X64_NONAME_F_SW_I2C u8g2(U8G2_R0, 22, 21);

// Keep 600 samples of 1s in history (10 minutes),
// calculate radiation for russian STS-6 ("CTC-6") Geiger tube
GeigerData geigerData(600, 1, STS6_CPM_PER_USPH);

// blinky state
int blinky = 1;

// Pulses counted by interrupt (while CPU is awake)
volatile uint16_t intPulseCount = 0;
// Pulses counted during ESP light sleep
volatile uint16_t pulseCount = 0;

// Sample duration in µs
const uint32_t sampleMicros = geigerData.sampleSeconds * 1000000;
// Absolute sample interval start micros
uint32_t sampleStart = 0;

void setup() {
	Serial.begin(921600);

	// high I2c clock still results in about 100ms buffer transmission to OLED:
	u8g2.setBusClock(1000000);
	u8g2.begin();

	// blinky
	pinMode(LED_BUILTIN, OUTPUT);

	// Geiger pulse input
	pinMode(PULSE_PIN, INPUT);

	// initialize sample start
	sampleStart = micros();
}

// interrupt handler
void pulse() {
	++intPulseCount;
}

uint32_t calcRemainingWait() {
	return sampleMicros - (micros() - sampleStart);
}

void loop() {

	// blinky

	digitalWrite(LED_BUILTIN, blinky);
	blinky = !blinky;

	// To save battery power, use light sleep as much as possible.
	// During light sleep, no counters or interrupts are working.
	// Therefore simply wake up on each pulse signal change. This
	// is fast enough for the low frequencies from a Geiger tube
	// (below 2kHz):
	// Wake up at end of sample period. Also
	// wake up on pulse getting high and getting low.
	// Waking up directly on rising/falling edges is not possible,
	// so wait until level change.
	// Switch to interrupt counting while awake for calculations
	// and display update.

	// stop interrupt (switch to active wakeup counting loop):
	detachInterrupt(PULSE_PIN);

	int32_t remainingWait = calcRemainingWait();
	esp_sleep_wakeup_cause_t cause = ESP_SLEEP_WAKEUP_UNDEFINED;
	while (cause != ESP_SLEEP_WAKEUP_TIMER && remainingWait > 0) {

		if (digitalRead(PULSE_PIN)) {
			// wait for low pulse start or sample time end
			esp_sleep_enable_timer_wakeup(remainingWait);
			gpio_wakeup_enable(PULSE_GPIO, GPIO_INTR_LOW_LEVEL);
			esp_sleep_enable_gpio_wakeup();
			esp_light_sleep_start();
			cause = esp_sleep_get_wakeup_cause();
		}

		remainingWait = calcRemainingWait();
		if (cause != ESP_SLEEP_WAKEUP_TIMER && remainingWait > 0) {
			// wait for high pulse start or sample time end
			esp_sleep_enable_timer_wakeup(remainingWait);
			gpio_wakeup_enable(PULSE_GPIO, GPIO_INTR_HIGH_LEVEL);
			esp_sleep_enable_gpio_wakeup();
			esp_light_sleep_start();
			cause = esp_sleep_get_wakeup_cause();
			if (cause == ESP_SLEEP_WAKEUP_GPIO) {
				++pulseCount;
			}
		}

		remainingWait = calcRemainingWait();
	}

	// take sample and add to statistics

	sampleStart = micros();
	const int16_t pulses = pulseCount + intPulseCount;
	//	Serial.print("pc=");
	//	Serial.print(pulseCount);
	//	Serial.print(" ipc=");
	//	Serial.println(intPulseCount);
	attachInterrupt(PULSE_PIN, pulse, RISING);
	interrupts();
	// reset counters AFTER enabling interrupt to avoid double-counting on high signal
	pulseCount = 0;
	intPulseCount = 0;

	geigerData.addPulses(pulses);
	geigerData.nextSample();

	// determine current value, average 6 seconds
	// because this is very near to the 5 seconds history
	// bar width and gives nicely rounded count values

	const uint16_t samples = 6;
	const uint32_t prevPulses = geigerData.getPreviousPulses(1, samples);
	const uint32_t cpm = prevPulses * (60 / samples);
	const float uSph = geigerData.toMicroSievertPerHour(prevPulses, samples);

	// test for display layout:
	// const uint32_t cpm = 1000*60;
	// const float uSph = geigerData.toMicroSievertPerHour(cpm, 60);

	char cpmStr[16];
	ltoa(cpm, cpmStr, 10);
	char uSphStr[16];
	sprintf(uSphStr, "%.2f", uSph);

	// serial output cpm and µS/h

	Serial.print(pulses);
	Serial.print(" ");
	Serial.print(cpmStr);
	Serial.print(" ");
	Serial.println(uSphStr);

	// render cpm and µS/h displays

	u8g2.clearBuffer();
	uint16_t y = 14;
	uint16_t xCpm = 56;
	uint16_t xUSph = 127;
	u8g2.setFont(u8g2_font_crox4hb_tr);

	u8g2_uint_t w = u8g2.getStrWidth(uSphStr);
	u8g2.setCursor(xUSph - w, y);
	u8g2.print(uSphStr);

	w = u8g2.getStrWidth(cpmStr);
	u8g2.setCursor(xCpm - w, y);
	u8g2.print(cpmStr);

	y = 21;
	u8g2.setFont(u8g2_font_4x6_tf);
	w = u8g2.getStrWidth("µS/h");
	u8g2.setCursor(xUSph - w, y);
	u8g2.print("µS/h");
	w = u8g2.getStrWidth("cnt/min");
	u8g2.setCursor(xCpm - w, y);
	u8g2.print("cnt/min");

	// history bar graph

	const uint16_t bars = 120;
	const uint16_t maxBarHeight = 40;
	const uint16_t samplesPerBar = geigerData.sampleCount / bars;
	const uint16_t barsPerMinute = 60
			/ (samplesPerBar * geigerData.sampleSeconds);

	// determine max value for y scale:
	uint16_t offset = geigerData.getCurrentSample() % samplesPerBar + 1;
	uint32_t maxPulses = 0;
	for (int16_t i = 0; i < bars - 1; i++) {
		const uint32_t prevPulses = geigerData.getPreviousPulses(offset,
				samplesPerBar);
		if (prevPulses > maxPulses)
			maxPulses = prevPulses;
		offset += samplesPerBar;
	}
	const float maxUSph = geigerData.toMicroSievertPerHour(maxPulses,
			samplesPerBar);
	const float uSphPerPixel = maxUSph > 40. ? 10. : maxUSph > 4. ? 1. :
								maxUSph > 0.4 ? 0.1 : 0.01;

	// labels and grid
	u8g2.setFont(u8g2_font_4x6_tn);
	char s[10];
	for (uint16_t i = 10; i <= maxBarHeight; i += 10) {
		u8g2.setCursor(0, 63 - i + 3);
		if (uSphPerPixel >= 0.1)
			sprintf(s, "%.0f", i * uSphPerPixel);
		else
			sprintf(s, ".%.0f", i * uSphPerPixel * 10);
		u8g2.print(s);
		for (int16_t x = 127 - barsPerMinute; x >= 8; x -= barsPerMinute) {
			u8g2.drawPixel(x, 63 - i);
		}
	}

	// bars
	offset = geigerData.getCurrentSample() % samplesPerBar + 1;
	for (int16_t i = 0; i < bars - 1; i++) {
		const uint32_t prevPulses = geigerData.getPreviousPulses(offset,
				samplesPerBar);
		const float uSph = geigerData.toMicroSievertPerHour(prevPulses,
				samplesPerBar);
		offset += samplesPerBar;
		uint16_t barHeight = 1 + (int) (uSph / uSphPerPixel);
		if (barHeight > 40)
			barHeight = 40;
		u8g2.drawVLine(127 - i, 63 - barHeight, barHeight);
	}

	u8g2.sendBuffer();
}
