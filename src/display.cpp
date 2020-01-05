#include "U8g2lib.h"

#include "display.h"

// OLED display 128x64 with SH1106 controller
// on I2C GPIOs SCL 22 and SDA 21
U8G2_SH1106_128X64_NONAME_F_SW_I2C u8g2(U8G2_R0, 22, 21);

void initDisplay()
{
	// high I2c clock still results in about 100ms buffer transmission to OLED:
	u8g2.setBusClock(1000000);
	u8g2.begin();
}

void renderDigits(char uSphStr[16], char cpmStr[16])
{
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
	w = u8g2.getStrWidth("\xB5S/h");
	u8g2.setCursor(xUSph - w, y);
	u8g2.print("\xB5S/h");

	w = u8g2.getStrWidth("cnt/min");
	u8g2.setCursor(xCpm - w, y);
	u8g2.print("cnt/min");
}

void renderHistoryBarGraph(GeigerData &geigerData)
{
	const uint16_t bars = 120;
	const uint16_t maxBarHeight = 40;
	const uint16_t samplesPerBar = geigerData.sampleCount / bars;
	const uint16_t barsPerMinute = 60 / (samplesPerBar * geigerData.sampleSeconds);

	// determine max value for y scale:
	uint16_t offset = geigerData.getCurrentSample() % samplesPerBar + 1;
	uint32_t maxPulses = 0;
	for (int16_t i = 0; i < bars - 1; i++)
	{
		const uint32_t prevPulses = geigerData.getPreviousPulses(offset,
																 samplesPerBar);
		if (prevPulses > maxPulses)
			maxPulses = prevPulses;

		offset += samplesPerBar;
	}

	const float maxUSph = geigerData.toMicroSievertPerHour(maxPulses,
														   samplesPerBar);
	const float uSphPerPixel = maxUSph > 40. ? 10. : maxUSph > 4. ? 1. : maxUSph > 0.4 ? 0.1 : 0.01;
	// labels and grid
	u8g2.setFont(u8g2_font_4x6_tn);
	char s[10];
	for (uint16_t i = 10; i <= maxBarHeight; i += 10)
	{
		u8g2.setCursor(0, 63 - i + 3);
		if (uSphPerPixel >= 0.1)
			sprintf(s, "%.0f", i * uSphPerPixel);
		else
			sprintf(s, ".%.0f", i * uSphPerPixel * 10);

		u8g2.print(s);
		for (int16_t x = 127 - barsPerMinute; x >= 8; x -= barsPerMinute)
		{
			u8g2.drawPixel(x, 63 - i);
		}
	}

	// bars
	offset = geigerData.getCurrentSample() % samplesPerBar + 1;
	for (int16_t i = 0; i < bars - 1; i++)
	{
		const uint32_t prevPulses = geigerData.getPreviousPulses(offset,
																 samplesPerBar);
		const float uSph = geigerData.toMicroSievertPerHour(prevPulses,
															samplesPerBar);
		offset += samplesPerBar;
		uint16_t barHeight = 1 + (int)((uSph / uSphPerPixel));
		if (barHeight > 40)
			barHeight = 40;

		u8g2.drawVLine(127 - i, 63 - barHeight, barHeight);
	}
}

void updateDisplay(GeigerData &geigerData, char uSphStr[16], char cpmStr[16])
{
	u8g2.clearBuffer();
	renderDigits(uSphStr, cpmStr);
	renderHistoryBarGraph(geigerData);
	u8g2.sendBuffer();
}
