#!/usr/bin/env ash

# Configure PHP-FPM
sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.d/www.conf \
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf \
sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini \
sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini \
sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini \
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini \
sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini \
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini \
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini \

# Configure PHP
sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini

# Configure WP
sed -i -e "s/database_name_here/wordpress/" -e "s/username_here/wordpress/" -e "s/password_here/${WORDPRESS_DATABASE_PASSWORD}/" -e "s/localhost/mysql/" /www/wp-config.php

# Verify if the volume contain wp-content
if [ -z "$(ls -A -- "/www/wp-content")" ]; then
	cp -r wp-content/* www/wp-content
fi

# Wait until mysql is up
until sudo -u www wp db check --path="/www"; do echo waiting for mysql; sleep 2; done

# If wordpress is not installed, install it
if ! $(sudo -u www wp core is-installed --path=/www); then
	sudo -u www wp core install --path=/www --url="$WORDPRESS_URL" --title="$WORDPRESS_SITE_TITLE" --admin_email="$WORDPRESS_ADMIN_EMAIL" --admin_user="$WORDPRESS_ADMIN" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --skip-email
	sudo -u www wp user create "$WORDPRESS_EDITOR" "$WORDPRESS_EDITOR_EMAIL" --user_pass="$WORDPRESS_EDITOR_PASSWORD" --role=editor --path=/www
	sudo -u www wp user create "$WORDPRESS_AUTHOR" "$WORDPRESS_AUTHOR_EMAIL" --user_pass="$WORDPRESS_AUTHOR_PASSWORD" --role=author --path=/www
	sudo -u www wp user create "$WORDPRESS_CONTRIBUTOR" "$WORDPRESS_CONTRIBUTOR_EMAIL" --user_pass="$WORDPRESS_CONTRIBUTOR_PASSWORD" --role=contributor --path=/www
fi

# Set permissions
chown -R www:www /www

# Remove default wp-content
rm -rf wp-content

# Start processes
/usr/sbin/php-fpm7
nginx -g 'daemon off;'
