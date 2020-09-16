FROM alpine:3.12

MAINTAINER gbudau

RUN apk add --update --no-cache  mysql mysql-client

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

#COPY my.cnf /etc/my.cnf
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

CMD ["/startup.sh"]
