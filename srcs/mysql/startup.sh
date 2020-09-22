#!/usr/bin/env ash

DIR="/var/lib/mysql"
/usr/bin/mysql_install_db --basedir=/usr --user=mysql --datadir="$DIR"
cat << EOF > tmp.sql
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'%' IDENTIFIED BY '${PMA_USER_DATABASE_PASSWORD}' ;
GRANT ALL ON *.* TO '${DATABASE_USER}'@'%' IDENTIFIED BY '${DATABASE_USER_PASSWORD}' ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF
/usr/bin/mysqld --defaults-file=/etc/my.cnf --user=mysql --bootstrap < create_tables.sql
/usr/bin/mysqld --defaults-file=/etc/my.cnf --user=mysql --bootstrap < tmp.sql
rm tmp.sql
rm create_tables.sql

exec /usr/bin/mysqld --user=mysql
