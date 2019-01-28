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
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"; \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"; \
    php composer-setup.php; \
    php -r "unlink('composer-setup.php');"; \
    ln -sf composer.phar composer; \
    php -f /usr/local/bin/composer.phar global require "squizlabs/php_codesniffer=*"; \
    ln -sf /root/.composer/vendor/bin/phpcs /usr/local/bin/phpcs; \
    ln -sf /root/.composer/vendor/bin/phpcs /usr/local/bin/phpcbf

WORKDIR /work
VOLUME /work
