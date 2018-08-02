#!/bin/bash -o pipefail

set -e

RELEASE_TAG=$CI_COMMIT_REF_NAME
DOCKER_TAG=$CI_COMMIT_SHA

# タグが作られていたらタグを優先
if [ ! -z "$CI_COMMIT_TAG" ]; then
    DOCKER_TAG=$CI_COMMIT_TAG
    RELEASE_TAG=$CI_COMMIT_TAG
fi

php_envs="7.2-apache 7.2-batch 7.2-phpcs"

for php_env in $php_envs
do
    docker build -t php/$php_env:$DOCKER_TAG \
        ./$php_env/

    # タグ付けするのはgitのtagが作られたときだけ
    if [ ! -z "$CI_COMMIT_TAG" ]; then
        # タグ付け
        docker tag php/$php_env:$DOCKER_TAG registry.gitlab.com/sameyasu/docker-php/$php_env:$DOCKER_TAG
        docker tag php/$php_env:$DOCKER_TAG registry.gitlab.com/sameyasu/docker-php/$php_env:latest
        # レジストリにプッシュ
        docker push registry.gitlab.com/sameyasu/docker-php/$php_env:$DOCKER_TAG
        docker push registry.gitlab.com/sameyasu/docker-php/$php_env:latest
    fi
done
