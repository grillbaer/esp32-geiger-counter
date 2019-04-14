#ifndef INGEST_H_
#define INGEST_H_

#include "GeigerData.h"

void initIngest();
void ingest(GeigerData &geigerData, uint16_t intervalSamples);

#endif /* INGEST_H_ */
