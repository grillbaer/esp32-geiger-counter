#include "credentials.h"

#if __has_include("secret_credentials.h")
// keep secret credentials in an external file that is never committed:
#include "secret_credentials.h"
#endif

#ifndef _SECRET_CREDENTIALS

// use dummy credentials to make it compilable without secrets
const char *wifiSsid = "unset-wifi-ssid";
const char *wifiPassword = "unset-password";
const char *thingspeakApiKey = ""; // empty to disable thinkspeak

const char *mqttHost = ""; // empty to disable MQTT
int mqttPort = 1833;
const char *mqttUser = "user";
const char *mqttPassword = "unset-password";
const char *mqttTopic = "home/geiger/radioactivity";

#endif
