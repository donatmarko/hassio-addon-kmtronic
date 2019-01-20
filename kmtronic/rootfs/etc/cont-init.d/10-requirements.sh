#!/usr/bin/with-contenv bash
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if ! hass.config.has_value 'topic'; then
    hass.die 'Setting the MQTT topic is REQUIRED!'
fi

if ! hass.config.has_value 'broker'; then
    hass.die 'Setting an MQTT broker is REQUIRED!'
fi

if ! hass.config.has_value 'port'; then
    hass.die 'Setting the MQTT port is REQUIRED!'
fi

if ! hass.config.has_value 'relays_count'; then
    hass.die 'Setting the count of the relays is REQUIRED!'
fi
