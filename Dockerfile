# syntax=docker/dockerfile:1

FROM alpine

# set version label
LABEL maintainer="Clion Nieh <76857061@qq.com>"

# environment settings
ENV BRANCH v3.12 
# The latest PHP7.3.33 and it's extensions contain in this version repository in alpine

# install packages
RUN set -eux; \
  #install build packages
  apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/main \
    --repository=http://dl-cdn.alpinelinux.org/alpine/$BRANCH/community \
    openssl \
    icu \
    php7 \
    php7-common \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-phar \
    php7-session \
    php7-simplexml \
    php7-xml \
    php7-xmlwriter \
    php7-zip \
    php7-bcmath \
    php7-dom \
    php7-ftp \
    php7-gd \
    php7-intl \
    php7-mysqli \
    php7-mysqlnd \
    php7-opcache \
    php7-pdo_mysql \
    php7-pecl-memcached \
    php7-pecl-redis \
    php7-soap \
    php7-sockets \
    php7-sodium \
    php7-sqlite3 \
    php7-xmlreader \
    php7-xsl \
    php7-pecl-xdebug \
    composer=1.10.19-r0; \
  \
  # Make dir for config and data
  mkdir -p /config; \
  \
  # Add user for php process
  adduser -u 82 -D -S -G www-data www-data; \
  \
  chown www-data:www-data /config; \
  \
  # guarantee correct php version is symlinked
  if [ "$(readlink /usr/bin/php)" != "php7" ]; then \
    rm -rf /usr/bin/php; \
    ln -s /usr/bin/php7 /usr/bin/php; \
  fi; \
  \
  # configure php
  sed -i "s#;error_log = log/php7/error.log.*#error_log = /config/log/php/php73/error.log#g" \
    /etc/php7/php-fpm.conf; \
  sed -i "s#user = nobody.*#user = www-data#g" \
    /etc/php7/php-fpm.d/www.conf; \
  sed -i "s#group = nobody.*#group = www-data#g" \
    /etc/php7/php-fpm.d/www.conf; \
  sed -i "s#listen = 127.0.0.1:9000.*#listen = 0.0.0.0:9000#g" \
    /etc/php7/php-fpm.d/www.conf

# add local files
COPY  --chmod=755 root/ /usr/local/bin

# set entrypoint
ENTRYPOINT ["init"]

# ports and volumes
EXPOSE 9000
VOLUME /config

CMD ["-F"]
