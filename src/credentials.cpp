#include "credentials.h"

#if __has_include("secret_credentials.h")
// keep secret credentials in an external file that is never committed:
#include "secret_credentials.h"
#endif

#ifndef _SECRET_CREDENTIALS

// use dummy credentials to make it compilable without secrets
const char *wifiSsid = "unset-wifi-ssid";
const char *wifiPassword = "unset-password";
const char *thingspeakApiKey = "unset-thinkspeak-api-key";

#endif
