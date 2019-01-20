#!/usr/bin/with-contenv bash
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

CONFIG='/opt/mqtt/config.py'    

# Ensure configuration exists
if hass.directory_exists '/opt/mqtt/'; then
    hass.log.info 'MQTT middleware directory exists.'

    cp -f /config/mqtt.py ${CONFIG}

    topic=$(hass.config.get 'topic')
    broker=$(hass.config.get 'broker')
    port=$(hass.config.get 'port')
    username=$(hass.config.get 'username')
    password=$(hass.config.get 'password')
    relays_count=$(hass.config.get 'relays_count')
    serial_port=$(hass.config.get 'serial_port')
    mqtt_discovery_prefix=$(hass.config.get 'mqtt_discovery_prefix')

    mqtt_discovery=$(hass.config.get 'mqtt_discovery')
    if ${mqtt_discovery} = true; then
        mqtt_discovery='True'
    else
        mqtt_discovery='False'
    fi

    sed -i "s~%%SERIAL_PORT%%~${serial_port}~" ${CONFIG}
    sed -i "s/%%TOPIC%%/${topic}/" ${CONFIG}
    sed -i "s/%%BROKER%%/${broker}/" ${CONFIG}
    sed -i "s/%%PORT%%/${port}/" ${CONFIG}
    sed -i "s/%%USERNAME%%/${username}/" ${CONFIG}
    sed -i "s/%%PASSWORD%%/${password}/" ${CONFIG}
    sed -i "s/%%RELAYS_COUNT%%/${relays_count}/" ${CONFIG}
    sed -i "s/%%MQTT_DISCOVERY%%/${mqtt_discovery}/" ${CONFIG}
    sed -i "s/%%MQTT_DISCOVERY_PREFIX%%/${mqtt_discovery_prefix}/" ${CONFIG}

    hass.log.info 'MQTT configuration saved.'
fi
