FROM php:7.3-cli

LABEL maintainer="sameyasu@gmail.com"

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y locales cron mysql-client wget git unzip && \
    cp -f /usr/share/zoneinfo/Japan /etc/localtime && \
    docker-php-ext-install pdo_mysql calendar

WORKDIR /usr/local/bin
RUN set -ex && \
    wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php --

WORKDIR /init.d
VOLUME /init.d

COPY entrypoint.sh /usr/local/bin

CMD ["entrypoint.sh"]
