#include <WiFi.h>

#include "GeigerData.h"

// WiFi and thingspeak credentials:
//const char *wifiSsid = "...";
//const char *wifiPassword = "...";
//const char *thingspeakApiKey = "...";
#include "credentials.h"

const char *thingsPeakUrl = "api.thingspeak.com";

void connect() {
	wl_status_t status = WL_DISCONNECTED;

	while (status != WL_CONNECTED) {
		WiFi.begin(wifiSsid, wifiPassword);
		Serial.print("Connecting to WiFi '");
		Serial.print(wifiSsid);
		Serial.println("' ...");
		uint16_t waitRemaining = 10;
		while ((status = WiFi.status()) != WL_CONNECTED && waitRemaining > 0) {
			Serial.print(" status=");
			Serial.println(status);
			delay(500);
			waitRemaining--;
		}
	}

	Serial.println("WiFi connected!");
}

void initIngest() {
	connect();
}

void ingest(GeigerData &geigerData, uint16_t intervalSamples) {
	WiFiClient client;
	if (!client.connect(thingsPeakUrl, 80)) {
		Serial.print("Connecting to '");
		Serial.print(thingsPeakUrl);
		Serial.println("' failed");
	} else {

		const uint32_t pulses = geigerData.getPreviousPulses(1,
				intervalSamples);
		const uint32_t cpm = uint32_t(
				pulses
						/ ((float) intervalSamples * geigerData.sampleSeconds
								/ 60.) + 0.5);
		const float uSph = geigerData.toMicroSievertPerHour(pulses,
				intervalSamples);

		const String content = "api_key=" + String(thingspeakApiKey)
				+ "&field1=" + String(cpm) + "&field2=" + String(uSph);

		Serial.println("Ingesting");

		client.print("POST /update HTTP/1.1\n");

		client.print("Host: ");
		client.print(thingsPeakUrl);
		client.print("\n");

		client.print("Connection: close\n");

		client.print("Content-Type: application/x-www-form-urlencoded\n");
		client.print("Content-Length: ");
		client.print(content.length());
		client.print("\n\n");

		client.print(content);
		delay(1000);

		Serial.print("Response: ");
		while (client.available()) {
			char c = client.read();
			Serial.write(c);
		}
		Serial.println();

		client.stop();
	}
}
