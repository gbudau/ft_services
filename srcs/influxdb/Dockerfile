FROM alpine:3.12

LABEL mantainer="gbudau"
ENV INFLUXDB_VERSION="1.8.2"

RUN wget https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz \
 && mkdir -p /usr/src /etc/influxdb \
 && tar -C /usr/src -xzf influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz \
 && rm -f /usr/src/influxdb-*/influxdb.conf \
 && chmod u+x /usr/src/influxdb-*/* \
 && cp -a /usr/src/influxdb-*/* /usr/bin/ \
 && rm -rf *.tar.gz /usr/src/influxdb-*

COPY startup.sh /startup.sh
RUN chmod u+x /startup.sh

VOLUME ["/var/lib/influxdb"]

EXPOSE 8086

CMD ["/startup.sh"]
