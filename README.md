# Docker-php73
### This image is builded base on latest alpine v3.19, modifyed the config to suport connect from network.

## Application Setup
* Add your web files to /config/www for hosting.
* Modify the php files under /config/php/php73 as needed
* Protip: This container is need combined with a sql server, e.g. mariadb and a webserver, e.g. nginx

## Parameters
* -v /config	Contains your www content and all relevant configuration files.
* -e PUID=99	for UserID - see below for explanation
* -e PGID=100	for GroupID - see below for explanation
* -e TZ=Etc/UTC	specify a timezone to use, see this list.

## Docker cli
```
docker run -d \
  --name=PHP73 \
  --net='bridge' \
  --ip='*.*.*.*' `#optional` \
  -e TZ="Asia/Shanghai" \
  -e 'UMASK'='022' \
  -e PUID=99 \
  -e PGID=100 \
  -p 9000:9000 `#optional` \
  -v /path/to/localconfigdir:/config:'rw' \
  --restart unless-stopped \
  registry.cn-chengdu.aliyuncs.com/clion/php73:latest
```

## PHP-fpm version
### v7.3.33

## Modules installed
*    php7-common
*    php7-ctype
*    php7-curl
*    php7-fpm
*    php7-iconv
*    php7-json
*    php7-mbstring
*    php7-openssl
*    php7-phar
*    php7-session
*    php7-simplexml
*    php7-xml
*    php7-xmlwriter
*    php7-zip
*    php7-bcmath
*    php7-dom
*    php7-ftp
*    php7-gd
*    php7-intl
*    php7-mysqli
*    php7-mysqlnd
*    php7-opcache
*    php7-pdo_mysql
*    php7-pecl-memcached
*    php7-pecl-redis
*    php7-soap
*    php7-sockets
*    php7-sodium
*    php7-sqlite3
*    php7-xmlreader
*    php7-xsl

## Composer version
### v1.10.19
