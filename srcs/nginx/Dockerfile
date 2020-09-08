# Set alpine 3.11 as base image
FROM alpine:3.11

# Install packages
RUN apk add --update --no-cache nginx openssl openssh

# Create ssl certificat and key for nginx
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=127.0.0.1' \
 && ssh-keygen -A \
 && adduser --disabled-password test \
 && echo "test:test" | chpasswd \
 && apk del openssl

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html


# Ports that needs to be exposed
EXPOSE 80
EXPOSE 443
EXPOSE 22

CMD /usr/sbin/sshd && nginx -g 'daemon off;'
