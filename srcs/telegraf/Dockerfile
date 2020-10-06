FROM alpine:3.12

LABEL maintainer="gbudau"

ARG TELEGRAF_VERSION="1.15.3"

# Install telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz \
 && mkdir -p /usr/src /etc/telegraf \
 && tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz \
 && rm -f /usr/src/telegraf*/etc/telegraf/telegraf.conf \
 && mkdir /etc/telegraf/telegraf.d \
 && cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ \
 && rm -rf *.tar.gz /usr/src

CMD ["telegraf"]
