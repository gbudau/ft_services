#!/usr/bin/env ash

sed -i "s/pmapass/${PMA_USER_DATABASE_PASSWORD}/" /usr/share/phpmyadmin/config.inc.php
/usr/sbin/php-fpm7
nginx -g 'daemon off;'
