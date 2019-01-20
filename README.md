# https://gitlab.com/sameyasu/docker-php/

![](https://img.shields.io/gitlab/pipeline/sameyasu/docker-php.svg?label=GitLab%20CI)

# Dockerイメージの一覧

|タグ|用途|
|:--|:--|
|[7.3-apache](https://gitlab.com/sameyasu/docker-php/blob/master/7.3-apache/Dockerfile)|apacheでphp7.3のWebアプリケーションを実行する|
|[7.3-batch](https://gitlab.com/sameyasu/docker-php/blob/master/7.3-batch/Dockerfile)|cronでphp7.3を実行する|
|[7.3-phpcs](https://gitlab.com/sameyasu/docker-php/blob/master/7.3-phpcs/Dockerfile)|php7.3でphpcs/phpcbfを実行する|
|[7.2-apache](https://gitlab.com/sameyasu/docker-php/blob/master/7.2-apache/Dockerfile)|apacheでphp7.2のWebアプリケーションを実行する|
|[7.2-batch](https://gitlab.com/sameyasu/docker-php/blob/master/7.2-batch/Dockerfile)|cronでphp7.2を実行する|
|[7.2-phpcs](https://gitlab.com/sameyasu/docker-php/blob/master/7.2-phpcs/Dockerfile)|php7.2でphpcs/phpcbfを実行する|

全てのタグでcomposer.pharが使えます。

# 使い方

## Webアプリケーション

- Dockerfileへの書き方例
```Dockerfile
FROM sameyasu/docker-php:7.3-apache
COPY . /path/to/your-app

ENV APACHE_DOCUMENT_ROOT /path/to/your-app/root
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /path/to/your-app
RUN composer.phar install
CMD [ "apache2-foreground" ]
```

- ビルドと実行方法
```
$ docker build -t your-php-app .
$ docker run --rm -it -p 8080:80 your-php-app
```

- ブラウザでのアクセス

http://localhost:8080/
にアクセスするとWebアプリケーションが実行されます。