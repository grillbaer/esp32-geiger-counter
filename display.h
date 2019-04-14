#ifndef DISPLAY_H_
#define DISPLAY_H_

#include "GeigerData.h"

void initDisplay();
void updateDisplay(GeigerData &geigerData, char uSphStr[16], char cpmStr[16]);

#endif /* DISPLAY_H_ */
