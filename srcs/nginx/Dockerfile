# Set alpine 3.12 as base image
FROM alpine:3.12

LABEL maintainer="gbudau"

# Install packages
RUN apk add --update --no-cache nginx openssl openssh

# Create ssl certificat and key for nginx
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=127.0.0.1' \
 && ssh-keygen -A \
 && adduser -SD test -s /bin/sh \
 && echo "test:test" | chpasswd

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html
COPY healthcheck.sh /healthcheck.sh
RUN chmod u+x healthcheck.sh


# Ports that needs to be exposed
EXPOSE 80
EXPOSE 443
EXPOSE 22

CMD /usr/sbin/sshd && nginx -g 'daemon off;'
