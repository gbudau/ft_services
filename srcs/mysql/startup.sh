#!/usr/bin/env ash

DIR="/var/lib/mysql"
/usr/bin/mysql_install_db --basedir=/usr --user=mysql --datadir="$DIR"
cat << EOF > tmp.sql
USE mysql;
FLUSH PRIVILEGES ;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
DROP DATABASE IF EXISTS test ;
FLUSH PRIVILEGES ;
EOF
/usr/bin/mysqld --defaults-file=/etc/my.cnf --user=mysql --bootstrap < tmp.sql
rm tmp.sql

exec /usr/bin/mysqld --user=mysql
