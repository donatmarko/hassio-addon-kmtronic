ARG BUILD_FROM=hassioaddons/base:2.3.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python3 requirements.txt
COPY requirements.txt /tmp/

# Setup base
RUN \
    apk add --no-cache --virtual .build-dependencies \
        python3-dev=3.6.6-r0 \
        git=2.18.1-r0 \
    \
    && apk add --no-cache \
        python3=3.6.6-r0 \
    \
    && pip3 install --upgrade pip==18.1 \
    && pip3 install --no-cache-dir -r /tmp/requirements.txt \
    \
    && git clone --branch "v1.1" --depth=1 \
        https://github.com/donatmarko/kmtronic-usb-relaybox-mqtt.git /opt/mqtt \
    \
    && rm -rf /opt/mqtt/.git \
    && rm -f /tmp/requirements.txt \
    \
    && apk del --purge .build-dependencies

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="KMTronic USB Relay Box" \
    io.hass.description="Connect your KMTronic USB Relay Box easily to Hass.io" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Donat Marko <sdf@donatus.hu>" \
    org.label-schema.description="Connect your KMTronic USB Relay Box easily to Hass.io" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="KMTronic USB Relay Box" \
    org.label-schema.schema-version="0.1" \
    org.label-schema.url="https://donatus.hu" \
    org.label-schema.usage="https://github.com/donatmarko/hassio-addon-kmtronic/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/donatmarko/hassio-addon-kmtronic" \
    org.label-schema.vendor="Donat Marko"
