# syntax=docker/dockerfile:1

FROM linuxserver/baseimage-alpine:3.19

# set version label
LABEL maintainer="Clion Nieh <76857061@qq.com>"

# install packages
RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/v3.12/main \
    --repository=http://dl-cdn.alpinelinux.org/alpine/v3.12/community \
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
    php7-xsl && \
  echo "**** guarantee correct php version is symlinked ****" && \
  if [ "$(readlink /usr/bin/php)" != "php7" ]; then \
    rm -rf /usr/bin/php && \
    ln -s /usr/bin/php7 /usr/bin/php; \
  fi && \
  echo "**** configure php ****" && \
  sed -i "s#;error_log = log/php7/error.log.*#error_log = /config/log/php/php7/error.log#g" \
    /etc/php7/php-fpm.conf && \
  sed -i "s#user = nobody.*#user = abc#g" \
    /etc/php7/php-fpm.d/www.conf && \
  sed -i "s#group = nobody.*#group = abc#g" \
    /etc/php7/php-fpm.d/www.conf && \
  echo "**** install php composer ****" && \
  apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/v3.12/community  composer=1.10.19-r0

# add local files
COPY root/ /
  
# ports and volumes
EXPOSE 9000

VOLUME /config
