# Set alpine 3.12 as base image
FROM alpine:3.12

LABEL maintainer="gbudau"
LABEL docker.group="nginx"

# Install packages
RUN apk add --update --no-cache nginx openssl openssh

# Create ssl certificat and key for nginx
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=127.0.0.1' \
 && ssh-keygen -A

# Copy files from host to image
COPY healthcheck.sh /healthcheck.sh
COPY startup.sh /startup.sh

# Set permission
RUN chmod u+x /healthcheck.sh /startup.sh


# Ports that needs to be exposed
EXPOSE 80
EXPOSE 443
EXPOSE 22

# Starting script
CMD ["/startup.sh"]
