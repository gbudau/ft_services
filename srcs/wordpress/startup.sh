#!/usr/bin/env ash

sed -i -e "s/database_name_here/wordpress/" -e "s/username_here/wordpress/" -e "s/password_here/${WORDPRESS_DATABASE_PASSWORD}/" -e "s/localhost/mysql/" /www/wp-config.php
if [ -z "$(ls -A -- "/www/wp-content")" ]; then
	cp -r wp-content/* www/wp-content
fi
until sudo -u www wp db check --path="/www"; do echo waiting for mysql; sleep 2; done
if ! $(sudo -u www wp core is-installed --path=/www); then
	sudo -u www wp core install --path=/www --url="$WORDPRESS_URL" --title="$WORDPRESS_SITE_TITLE" --admin_email="$WORDPRESS_ADMIN_EMAIL" --admin_user="$WORDPRESS_ADMIN" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --skip-email
	sudo -u www wp user create "$WORDPRESS_EDITOR" "$WORDPRESS_EDITOR_EMAIL" --user_pass="$WORDPRESS_EDITOR_PASSWORD" --role=editor --path=/www
	sudo -u www wp user create "$WORDPRESS_AUTHOR" "$WORDPRESS_AUTHOR_EMAIL" --user_pass="$WORDPRESS_AUTHOR_PASSWORD" --role=author --path=/www
	sudo -u www wp user create "$WORDPRESS_CONTRIBUTOR" "$WORDPRESS_CONTRIBUTOR_EMAIL" --user_pass="$WORDPRESS_CONTRIBUTOR_PASSWORD" --role=contributor --path=/www
fi
chown -R www:www /www
rm -rf wp-content
/usr/sbin/php-fpm7
nginx -g 'daemon off;'
