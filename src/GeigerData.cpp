#include "GeigerData.h"

GeigerData::GeigerData(uint16_t sampleCount, uint16_t sampleSeconds,
					   float cpm_per_uSph) : sampleCount(sampleCount), sampleSeconds(sampleSeconds), cpm_per_uSph(cpm_per_uSph), pulsesPerSample(new uint16_t[sampleCount])
{
	currentSample = 0;
	for (int i = 0; i < sampleCount; i++)
	{
		pulsesPerSample[i] = 0;
	}
}

GeigerData::~GeigerData()
{
	delete[] pulsesPerSample;
}

uint16_t GeigerData::next(uint16_t index)
{
	return index + 1 < sampleCount ? index + 1 : 0;
}

uint16_t GeigerData::prev(uint16_t index)
{
	return index > 0 ? index - 1 : sampleCount - 1;
}

void GeigerData::addPulses(uint16_t pulses)
{
	if (pulsesPerSample[currentSample] <= UINT16_MAX - pulses)
		pulsesPerSample[currentSample] += pulses;
}

void GeigerData::nextSample()
{
	currentSample = next(currentSample);
	pulsesPerSample[currentSample] = 0;
}

uint16_t GeigerData::getCurrentSample()
{
	return currentSample;
}

uint32_t GeigerData::getPreviousPulses(uint16_t offset, uint16_t samples)
{
	uint32_t pulses = 0;
	uint16_t index = (currentSample + sampleCount - offset) % sampleCount;
	for (uint16_t i = 0; i < samples; i++)
	{
		pulses += pulsesPerSample[index];
		index = prev(index);
	}

	return pulses;
}

float GeigerData::toMicroSievertPerHour(uint32_t pulses, uint16_t samples)
{
	float cpm = pulses / (sampleSeconds / 60. * samples);
	return cpm / cpm_per_uSph;
}
