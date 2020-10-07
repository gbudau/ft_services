FROM alpine:3.12

LABEL maintainer="gbudau"
LABEL docker.group="ftps"

RUN apk add --update --no-cache vsftpd openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt -subj '/CN=127.0.0.1'

COPY startup.sh /startup.sh
RUN chmod u+x /startup.sh

EXPOSE 21 30020-30039

VOLUME ["/vsftpd"]
CMD ["/startup.sh"]
