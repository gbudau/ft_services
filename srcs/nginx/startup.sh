#!/usr/bin/env ash

adduser -SD "$SSH_USER" -s /bin/sh
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd
/usr/sbin/sshd

mkdir -p /usr/share/nginx/html
wget "$WEB_PAGE" -O /usr/share/nginx/html/index.html
nginx -g 'daemon off;'
