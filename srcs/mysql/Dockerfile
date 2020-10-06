FROM alpine:3.12

LABEL maintainer="gbudau"
LABEL docker.group="mysql"

RUN addgroup -S mysql && adduser -S -G mysql mysql
RUN apk add --update --no-cache  mysql mysql-client
RUN rm -rf /var/lib/mysql \
 && mkdir -p /var/run/mysqld /var/lib/mysql \
 && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
 && chmod 777 /var/run/mysqld

EXPOSE 3306


COPY create_tables.sql .
COPY startup.sh /startup.sh
RUN chmod u+x /startup.sh

VOLUME ["/var/lib/mysql"]

CMD ["/startup.sh"]
