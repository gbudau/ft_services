FROM alpine:3.12

LABEL maintainer="gbudau"
LABEL docker.group="wordpress"

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

# Install packages
RUN apk add --update --no-cache nginx \
 sudo \
 openssl \
 coreutils \
 mysql-client \
 php7 \
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
 php7-mbstring \
 php7-exif \
 php7-fileinfo \
 php7-pecl-imagick \
 php7-phar



# Create www user and group, change permission
RUN adduser -D -g 'www' www \
 && mkdir /www \
 && chown -R www:www /var/lib/nginx

# Install wordpress && wp-cli
RUN wget -q https://wordpress.org/latest.tar.gz -P tmp \
 && tar xzf tmp/latest.tar.gz -C tmp \
 && cp -r tmp/wordpress/* /www \
 && chown -R www:www /www \
 && cd /www \
 && wget -q https://api.wordpress.org/secret-key/1.1/salt/ -O salt \
 && csplit -s wp-config-sample.php '/AUTH_KEY/' '/NONCE_SALT/+1' \
 && cat xx00 salt xx02 > wp-config.php \
 && rm salt xx00 xx01 xx02 \
 && cd / \
 && wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp/ \
 && chmod +x tmp/wp-cli.phar \
 && mv tmp/wp-cli.phar usr/local/bin/wp \
 && cp -r tmp/wordpress/wp-content . \
 && rm -rf tmp/*


# Copy and set permission for config files and starting script
COPY startup.sh /startup.sh
COPY healthcheck.sh /healthcheck.sh
RUN chmod u+x /startup.sh /healthcheck.sh


# Ports that needs to be exposed
EXPOSE 5050

VOLUME ["/www/wp-content"]

CMD ["/startup.sh"]
