#!/usr/bin/with-contenv bash
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

PORT=$(hass.config.get 'serial_port')

if [ -r ${PORT} ]; then
    hass.log.info "Serial port (${PORT}) exists."
else
    hass.log.warning '--------------------------------------------------'
    if ! hass.config.has_value 'serial_port'; then
        hass.log.warning 'No serial port was set!'
    else
        hass.log.warning "The given serial port (${PORT}) does not exist."
    fi
    hass.log.warning '--------------------------------------------------'
    hass.log.warning 'List of available serial ports:'

    find /dev -regex "\/dev\/ttyACM[0-9]" | while read line; do
        hass.log.warning '     ' ${line}
    done
    find /dev -regex "\/dev\/ttyAMA[0-9]" | while read line; do
        hass.log.warning '     ' ${line}
    done
    find /dev -regex "\/dev\/ttyUSB[0-9]" | while read line; do
        hass.log.warning '     ' ${line}
    done
    hass.log.warning '--------------------------------------------------'

    hass.die 'Save the chosen port and restart the add-on!'
fi