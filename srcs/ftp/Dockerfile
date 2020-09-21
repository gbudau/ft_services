FROM alpine:3.12

LABEL maintainer="gbudau"

RUN apk add --update --no-cache vsftpd

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN mkdir /srv/ftp \
 && chown nobody:nogroup /srv/ftp \
 && echo "anon" >  /srv/ftp/anon.txt

EXPOSE 21 30020 30021

CMD /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
