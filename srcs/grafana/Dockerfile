FROM alpine:3.12

LABEL mantainer="gbudau"

RUN addgroup -S grafana && adduser -S grafana -G grafana

RUN apk add --update --no-cache libaio libnsl \
 && ln -s /usr/lib/libnsl.so.2 /usr/lib/libnsl.so.1 \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk -O /tmp/glibc-2.30-r0.apk \
 && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-bin-2.30-r0.apk -O /tmp/glibc-bin-2.30-r0.apk \
 && apk add --allow-untrusted /tmp/glibc-2.30-r0.apk /tmp/glibc-bin-2.30-r0.apk \
 && mkdir /usr/share/grafana \
 && wget -q https://dl.grafana.com/oss/release/grafana-latest.linux-x64-musl.tar.gz -P tmp \
 && tar xfz /tmp/grafana-latest.linux-x64-musl.tar.gz --strip-components=1 -C /usr/share/grafana \
 && rm -rf /tmp/* \
 && rm -f /lib/ld-linux-x86-64.so.2 \
 && mkdir -p /etc/grafana/provisioning/datasources \
 && mkdir -p /etc/grafana/provisioning/dashboards \
 && mkdir -p /etc/grafana/provisioning/notifiers \
 && mkdir -p /etc/grafana/provisioning/plugins \
 && mkdir -p /var/log/grafana \
 && mkdir -p /var/lib/grafana/plugins \
 && mkdir -p /var/lib/grafana/dashboards \
 && cp /usr/share/grafana/conf/sample.ini /etc/grafana/grafana.ini \
 && sed -i 's|;provisioning = conf/provisioning|provisioning = /etc/grafana/provisioning|i' /etc/grafana/grafana.ini \
 && sed -i 's|;mode = console file|mode = console|i' /etc/grafana/grafana.ini \
 && sed -i 's|;data = /var/lib/grafana|data = /var/lib/grafana|i' /etc/grafana/grafana.ini \
 && sed -i 's|;plugins = /var/lib/grafana/plugins|plugins = /var/lib/grafana/plugins|i' /etc/grafana/grafana.ini \
 && cp /usr/share/grafana/conf/ldap.toml /etc/grafana/ldap.toml \
 && chown -R grafana:grafana /var/lib/grafana /var/log/grafana /etc/grafana/provisioning

COPY datasources.yaml /etc/grafana/provisioning/datasources/datasources.yaml
COPY dashboards.yaml /etc/grafana/provisioning/dashboards/dashboards.yaml
COPY telegraf-metrics.json /var/lib/grafana/dashboards/telegraf-metrics.json

EXPOSE 3000

USER grafana

CMD /usr/share/grafana/bin/grafana-server --homepath=/usr/share/grafana --config=/etc/grafana/grafana.ini --packaging=docker
