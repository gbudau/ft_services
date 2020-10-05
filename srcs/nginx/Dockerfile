# Set alpine 3.12 as base image
FROM alpine:3.12

LABEL maintainer="gbudau"

ARG TELEGRAF_VERSION="1.15.3"

# Install packages
RUN apk add --update --no-cache nginx openssl openssh \
 && mkdir -p /usr/share/nginx/html \
 && wget https://www.42madrid.com/ -O /usr/share/nginx/html/index.html

# Create ssl certificat and key for nginx
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=127.0.0.1' \
 && ssh-keygen -A

# Install telegraf
RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz \
 && mkdir -p /usr/src /etc/telegraf \
 && tar -C /usr/src -xzf telegraf-${TELEGRAF_VERSION}_static_linux_amd64.tar.gz \
 && rm -f /usr/src/telegraf*/etc/telegraf/telegraf.conf \
 && mkdir /etc/telegraf/telegraf.d \
 && cp -a /usr/src/telegraf*/usr/bin/telegraf /usr/bin/ \
 && rm -rf *.tar.gz /usr/src

# Copy files from host to image
COPY healthcheck.sh /healthcheck.sh
COPY startup.sh /startup.sh
RUN chmod u+x /healthcheck.sh /startup.sh


# Ports that needs to be exposed
EXPOSE 80
EXPOSE 443
EXPOSE 22

# Starting script
CMD ["/startup.sh"]
