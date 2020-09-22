FROM alpine:3.12

LABEL maintainer="gbudau"

# Environmental variables
ENV PHP_FPM_USER="www"
ENV PHP_FPM_GROUP="www"
ENV PHP_FPM_LISTEN_MODE="0660"
ENV PHP_MEMORY_LIMIT="512M"
ENV PHP_MAX_UPLOAD="50M"
ENV PHP_MAX_FILE_UPLOAD="200"
ENV PHP_MAX_POST="100M"
ENV PHP_DISPLAY_ERRORS="On"
ENV PHP_DISPLAY_STARTUP_ERRORS="On"
ENV PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
ENV PHP_CGI_FIX_PATHINFO="0"
ENV PHPMYADMIN_VERSION="5.0.2"

# Install packages
RUN apk add --update --no-cache nginx \
 openssl \
 php7-fpm \
 php7-mcrypt \
 php7-soap \
 php7-openssl \
 php7-gmp \
 php7-pdo_odbc \
 php7-json \
 php7-dom \
 php7-pdo \
 php7-zip \
 php7-mysqli \
 php7-sqlite3 \
 php7-apcu \
 php7-pdo_pgsql \
 php7-bcmath \
 php7-gd \
 php7-odbc \
 php7-pdo_mysql \
 php7-pdo_sqlite \
 php7-gettext \
 php7-xmlreader \
 php7-xmlrpc \
 php7-bz2 \
 php7-iconv \
 php7-pdo_dblib \
 php7-curl \
 php7-ctype \
 php7-session \
 php7-mbstring


# Create www user and group, change permission
RUN adduser -D -g 'www' www \
 && mkdir /www \
 && chown -R www:www /var/lib/nginx \
 && chown -R www:www /www


# Install phpmyadmin
RUN wget -q https://files.phpmyadmin.net/phpMyAdmin/${PHPMYADMIN_VERSION}/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz -P tmp \
 && tar xzf tmp/phpMyAdmin-${PHPMYADMIN_VERSION}-english.tar.gz -C tmp \
 && mv tmp/phpMyAdmin-${PHPMYADMIN_VERSION}-english/ /usr/share/phpmyadmin \
 && mkdir -p /var/lib/phpmyadmin/tmp \
 && chown -R www:www /var/lib/phpmyadmin \
 && randomBlowfishSecret=$(openssl rand -base64 32) \
 && sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" -e '/controluser/,/End/ s/^\/\///g' /usr/share/phpmyadmin/config.sample.inc.php > /usr/share/phpmyadmin/config.inc.php \
 && sed -i "s/localhost/mysql/" /usr/share/phpmyadmin/config.inc.php \
 && echo "\$cfg['TempDir'] = '/var/lib/phpmyadmin/tmp';" >> /usr/share/phpmyadmin/config.inc.php \
 && ln -s /usr/share/phpmyadmin/ /www/ \
 && rm -rf tmp/*
 

RUN sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
 && sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
 && sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.d/www.conf \
 && sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
 && sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
 && sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf \
 && sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini \
 && sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini \
 && sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini \
 && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini \
 && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini \
 && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini \
 && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini \
 && sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini


COPY nginx.conf /etc/nginx/nginx.conf
COPY startup.sh /startup.sh
RUN chmod u+x /startup.sh


# Ports that needs to be exposed
EXPOSE 5000

CMD ["/startup.sh"]
