#!/usr/bin/env ash

adduser -SD "$SSH_USER" -s /bin/sh
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd
/usr/sbin/sshd
telegraf &
nginx -g 'daemon off;'
