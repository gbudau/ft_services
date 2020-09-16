#!/usr/bin/env ash

DIR="/var/lib/mysql"
# Check if directory is empty
if [ -z "$(ls -A $DIR)" ]; then
	/usr/bin/mysql_install_db --user=mysql --datadir="$DIR"
fi
exec /usr/bin/mysqld_safe
