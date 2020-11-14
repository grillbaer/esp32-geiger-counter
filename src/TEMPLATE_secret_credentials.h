#define _SECRET_CREDENTIALS

// Copy this file to secret_credentials.h and adjust for
// your needs and environment.

// !!! NEVER COMMIT YOUR SECRETS !!!

const char *wifiSsid = "MyWiFi";
const char *wifiPassword = "mypassword";


// ThingsPeak Channel

// set key to NULL or empty string to disable ThingsPeak ingest:
const char *thingspeakApiKey = "MYAPIKEY";


// MQTT Broker

// set host to NULL or empty string to disable MQTT publishing:
const char *mqttHost = "my.mqtt.server";
int mqttPort = 1833;
const char *mqttUser = "user";
const char *mqttPassword = "mypassword";
const char *mqttTopic = "home/radioactivity";
