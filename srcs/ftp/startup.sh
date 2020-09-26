#!/usr/bin/env ash

echo "$FTP_USER" >> /etc/vsftpd.allowed_users
adduser -D -h /vsftpd/"$FTP_USER" -s /sbin/nologin "$FTP_USER"
echo "$FTP_USER:$FTP_USER_PASS" | chpasswd
mkdir -p /vsftpd/"$FTP_USER"
chown "$FTP_USER:$FTP_USER" /vsftpd/"$FTP_USER"
echo "pasv_address=$FTP_EXTERNAL_IP" >> /etc/vsftpd/vsftpd.conf
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
