# Geiger counter based on ESP32 with OLED display and thingspeak channel

- Low power mode for battery power supply without WiFi, only with OLED display and click sounds
- WiFi mode for thingspeak data upload

# Hardware

- Russian Geiger counter tube STS-6 at 400 V with ~5 MOhm
- High voltage circuit from ArnoR at mikrocontroller.net https://www.mikrocontroller.net/topic/380666, schematic https://www.mikrocontroller.net/attachment/273334/HystereseStepUpTLC555-2.png
- ~400 µs pulses generation using voltage divider, darlington transistor and TLC 555 timer
- ESP 32 board Wemos Lolin32
- OLED 128x64 with controller SH1106 at I2C
- Voltage supply from USB or power supply or 3x1.5V AAA batteries, works from 3.0 V up to 5.0 V

![Circuit Board](media/geiger-counter-pcb.jpg)

# Software

- Eclipse sloeber project using Arduino library, ESP-IDF for sleep functions and u8g2 for display output
