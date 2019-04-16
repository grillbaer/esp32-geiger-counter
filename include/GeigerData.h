#ifndef GEIGERDATA_H_
#define GEIGERDATA_H_

#include "Arduino.h"

// Russion STS-6 ("CTC-6") Geiger tube:
// N = (2.28-3.42)*10^3 at 0.36 µR/h; Nmax = 6*10^4; Nf = 110
const float STS6_CPM_PER_USPH = 875;

// Holds pulse counter history and performs calculations
class GeigerData {
public:
	const uint16_t sampleCount;
	const uint16_t sampleSeconds;
	const float cpm_per_uSph;

private:
	uint16_t currentSample;
	uint16_t *pulsesPerSample;
	uint16_t next(uint16_t index);
	uint16_t prev(uint16_t index);

public:

	GeigerData(uint16_t sampleCount, uint16_t sampleSeconds,
			float cpm_per_uSph);
	virtual ~GeigerData();

	virtual void addPulses(uint16_t pulses);
	virtual void nextSample();

	virtual uint16_t getCurrentSample();
	virtual uint32_t getPreviousPulses(uint16_t offset, uint16_t samples);
	virtual float toMicroSievertPerHour(uint32_t pulses, uint16_t samples);
};

#endif /* GEIGERDATA_H_ */
