#include <Arduino.h>
#include "driver/pcnt.h"
#include "driver/gpio.h"
#include "driver/rtc_io.h"
#include "display.h"
#include "ingest.h"
#include "GeigerData.h"

// ~400µs high pulses from Geiger tube on GPIO 18
#define PULSE_PIN 18
#define PULSE_GPIO GPIO_NUM_18

// switch input for WiFi on (low) and off (high)
#define WIFI_SWITCH_PIN 4

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

const int16_t ingestInterval = 60;
int16_t ingestCountdown;

void pulse();
uint32_t calcRemainingWait();
boolean wifiSwitchOn();
uint16_t takeSampleNoSleep();
uint16_t takeSampleLowPower();

void setup()
{
	Serial.begin(921600);
	Serial.println("Starting!");

	// OLED
	initDisplay();

	// blinky
	pinMode(LED_BUILTIN, OUTPUT);

	// Geiger pulse input
	pinMode(PULSE_PIN, INPUT);

	// WiFi switch input
	pinMode(WIFI_SWITCH_PIN, INPUT_PULLUP);

	if (wifiSwitchOn())
	{
		initIngest();
	}

	// initialize sample start
	sampleStart = micros();
	ingestCountdown = ingestInterval;
}

void loop()
{

	// blinky

	digitalWrite(LED_BUILTIN, blinky);
	blinky = !blinky;

	const uint16_t pulses =
		wifiSwitchOn() ? takeSampleNoSleep() : takeSampleLowPower();

	geigerData.addPulses(pulses);
	geigerData.nextSample();

	if (wifiSwitchOn())
	{
		ingestCountdown--;
		if (ingestCountdown <= 0)
		{
			ingestCountdown = ingestInterval;
			ingest(geigerData, ingestInterval);
		}
	}
	else
	{
		deinitIngest();
	}

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

	updateDisplay(geigerData, uSphStr, cpmStr);
}

// interrupt handler
void pulse()
{
	++intPulseCount;
}

uint32_t calcRemainingWait()
{
	const uint32_t remaining = sampleMicros - (micros() - sampleStart);
	return remaining > sampleMicros ? 0 : remaining;
}

boolean wifiSwitchOn()
{
	return digitalRead(WIFI_SWITCH_PIN) == 0;
}

uint16_t takeSampleNoSleep()
{
	attachInterrupt(PULSE_PIN, pulse, RISING);

	int32_t remainingWait = calcRemainingWait();
	delayMicroseconds(remainingWait);
	sampleStart = micros();
	noInterrupts();
	const int16_t pulses = intPulseCount;
	intPulseCount = 0;
	interrupts();

	return pulses;
}

uint16_t takeSampleLowPower()
{
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
	while (cause != ESP_SLEEP_WAKEUP_TIMER && remainingWait > 0)
	{

		if (digitalRead(PULSE_PIN))
		{
			// wait for low pulse start or sample time end
			esp_sleep_enable_timer_wakeup(remainingWait);
			gpio_wakeup_enable(PULSE_GPIO, GPIO_INTR_LOW_LEVEL);
			esp_sleep_enable_gpio_wakeup();
			esp_light_sleep_start();
			cause = esp_sleep_get_wakeup_cause();
		}

		remainingWait = calcRemainingWait();
		if (cause != ESP_SLEEP_WAKEUP_TIMER && remainingWait > 0)
		{
			// wait for high pulse start or sample time end
			esp_sleep_enable_timer_wakeup(remainingWait);
			gpio_wakeup_enable(PULSE_GPIO, GPIO_INTR_HIGH_LEVEL);
			esp_sleep_enable_gpio_wakeup();
			esp_light_sleep_start();
			cause = esp_sleep_get_wakeup_cause();
			if (cause == ESP_SLEEP_WAKEUP_GPIO)
			{
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

	return pulses;
}
