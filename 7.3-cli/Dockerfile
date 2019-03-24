FROM php:7.3-cli

LABEL maintainer="sameyasu@gmail.com"

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y locales cron mysql-client wget git unzip && \
    cp -f /usr/share/zoneinfo/Japan /etc/localtime && \
    docker-php-ext-install pdo_mysql calendar && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin
RUN set -ex; \
    wget https://getcomposer.org/composer.phar; \
    chmod +x composer.phar; \
    ln -sf composer.phar composer
