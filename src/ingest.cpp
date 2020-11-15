#include <WiFi.h>
#include <MQTT.h>

#include "GeigerData.h"

#include "credentials.h"

const char *thingsPeakUrl = "api.thingspeak.com";

WiFiClient mqttWifiClient;
MQTTClient mqttClient;

bool connectWiFi()
{
	uint16_t retries = 10;
	while (WiFi.status() != WL_CONNECTED && (retries--) > 0)
	{
		Serial.print("Trying to connect to ");
		Serial.print(wifiSsid);
		Serial.print(" ... ");
		WiFi.begin(wifiSsid, wifiPassword);
		uint16_t waitRemaining = 8;
		while (WiFi.status() != WL_CONNECTED && (--waitRemaining) > 0)
		{
			delay(500);
		}
		if (WiFi.status() == WL_CONNECTED)
		{
			Serial.println("successful");
			return true;
		}
		else
		{
			Serial.print("failed status=");
			Serial.println(WiFi.status());
		}
	}

	return WiFi.status() == WL_CONNECTED;
}

void disconnectWiFi()
{
	Serial.println("Disconnecting WiFi");
	WiFi.disconnect(true, true);
}

void initIngest()
{
	connectWiFi();
}

void loopIngest()
{
	if (mqttClient.connected())
	{
		mqttClient.loop();
	}
}

void deinitIngest()
{
	if (WiFi.status() == WL_CONNECTED)
	{
		disconnectWiFi();
	}
}

void ingestToThingspeak(GeigerData &geigerData, uint16_t intervalSamples)
{
	if (!connectWiFi())
		return;

	if (thingsPeakUrl == NULL || thingsPeakUrl[0] == 0)
		return;

	WiFiClient client;
	if (!client.connect(thingsPeakUrl, 80))
	{
		Serial.print("Connecting to ");
		Serial.print(thingsPeakUrl);
		Serial.println(" failed");
		// disconnect from WiFi to trigger fresh connect on next ingest
		disconnectWiFi();
	}
	else
	{
		client.setTimeout(30);

		const uint32_t pulses = geigerData.getPreviousPulses(1,
															 intervalSamples);
		const uint32_t cpm = uint32_t(
			pulses / ((float)intervalSamples * geigerData.sampleSeconds / 60.) + 0.5);
		const float uSph = geigerData.toMicroSievertPerHour(pulses,
															intervalSamples);

		const String content = "api_key=" + String(thingspeakApiKey) + "&field1=" + String(cpm) + "&field2=" + String(uSph, 3);

		Serial.print("Ingesting cpm=");
		Serial.print(cpm);
		Serial.print(" uSph=");
		Serial.print(uSph, 3);
		Serial.print(" ... ");

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

		uint16_t timeout = 40;
		while (client.available() == 0 && (--timeout) > 0)
		{
			delay(50);
		}
		if (client.available() == 0)
		{
			Serial.println("failed (no response)");
		}

		Serial.println("response:");
		while (client.available())
		{
			char c = client.read();
			Serial.write(c);
		}
		Serial.println();

		client.stop();
	}
}

bool connectMqtt()
{
	if (!connectWiFi())
		return false;

	if (mqttHost == NULL || mqttHost[0] == 0)
		return false;

	if (!mqttClient.connected())
	{
		Serial.print("Connecting to MQTT host ");
		Serial.print(mqttHost);
		Serial.print(":");
		Serial.print(mqttPort);
		Serial.print(" user ");
		Serial.print(mqttUser);
		mqttClient.begin(mqttHost, mqttPort, mqttWifiClient);
		if (mqttClient.connect("esp32-geiger-counter", mqttUser, mqttPassword))
		{
			Serial.println(" successful");
		}
		else
		{
			Serial.println(" failed");
			// disconnect from WiFi to trigger fresh connect on next ingest
			disconnectWiFi();
			return false;
		}
	}

	return true;
}

void disconnectMqtt()
{
	mqttClient.disconnect();
}

void ingestToMqtt(GeigerData &geigerData, uint16_t intervalSamples)
{
	if (connectMqtt())
	{
		const unsigned long pulses = geigerData.getPreviousPulses(1,
																  intervalSamples);
		const unsigned long cpm = (unsigned long)(pulses / ((float)intervalSamples * geigerData.sampleSeconds / 60.) + 0.5);
		const float uSph = geigerData.toMicroSievertPerHour(pulses,
															intervalSamples);
		char payload[129];
		sprintf(payload, "{\"pulses\":%lu, \"cpm\":%lu,\"uSph\":%.3f,\"secs\":%d}",
				pulses, cpm, uSph, (int)intervalSamples);

		if (!mqttClient.publish(mqttTopic, payload))
		{
			mqttClient.disconnect();
		}
	}
}
