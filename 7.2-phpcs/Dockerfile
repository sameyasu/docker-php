FROM php:7.2-cli

LABEL maintainer="sameyasu@gmail.com"

ENV LANG C.UTF-8

RUN apt-get update && \
    apt-get install -y locales cron wget git unzip && \
    cp -f /usr/share/zoneinfo/Japan /etc/localtime && \
    docker-php-ext-install calendar && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/local/bin
RUN set -ex; \
    wget https://getcomposer.org/composer.phar; \
    chmod +x composer.phar; \
    ln -sf composer.phar composer; \
    php -f /usr/local/bin/composer.phar global require "squizlabs/php_codesniffer=*"; \
    ln -sf /root/.composer/vendor/bin/phpcs /usr/local/bin/phpcs; \
    ln -sf /root/.composer/vendor/bin/phpcs /usr/local/bin/phpcbf

WORKDIR /work
VOLUME /work
