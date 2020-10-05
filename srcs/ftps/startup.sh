#!/usr/bin/env ash

echo "$FTPS_USER" >> /etc/vsftpd.allowed_users
adduser -D -h /vsftpd/"$FTPS_USER" -s /sbin/nologin "$FTPS_USER"
echo "$FTPS_USER:$FTPS_USER_PASS" | chpasswd
mkdir -p /vsftpd/"$FTPS_USER"
chown "$FTPS_USER:$FTPS_USER" /vsftpd/"$FTPS_USER"
exec /usr/sbin/vsftpd "-opasv_address=$FTPS_EXTERNAL_IP" /etc/vsftpd/vsftpd.conf
