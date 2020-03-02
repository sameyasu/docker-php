#!/bin/bash -o pipefail

set -e

RELEASE_TAG=$CI_COMMIT_REF_NAME
DOCKER_TAG=$CI_COMMIT_SHA

php_envs="7.2-apache 7.2-batch 7.2-phpcs 7.2-cli 7.3-apache 7.3-batch 7.3-phpcs 7.3-cli 7.4-apache 7.4-batch 7.4-phpcs 7.4-cli"

for php_env in $php_envs
do
    docker build -t php/$php_env:$DOCKER_TAG \
        ./$php_env/

    # タグ付けするのはgitのbranchがmasterのときだけ
    if [ "$CI_COMMIT_REF_NAME" = "master" ]; then
        # タグ付け
        docker tag php/$php_env:$DOCKER_TAG registry.gitlab.com/sameyasu/docker-php/$php_env:latest
        # レジストリにプッシュ
        docker push registry.gitlab.com/sameyasu/docker-php/$php_env:latest
    fi
done
