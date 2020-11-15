#ifndef INGEST_H_
#define INGEST_H_

#include "GeigerData.h"

void initIngest();
void loopIngest();
void deinitIngest();
void ingestToThingspeak(GeigerData &geigerData, uint16_t intervalSamples);
void ingestToMqtt(GeigerData &geigerData, uint16_t intervalSamples);

#endif /* INGEST_H_ */
