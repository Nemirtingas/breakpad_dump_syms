#! /bin/bash

NAME=breakpad_dump_syms
VERSION=latest
DOCKER_WINE_VER=stable-9.0

container_name="$(mktemp -u XXXXXXXXXXXX)"

docker build --build-arg "DOCKER_WINE_VER=${DOCKER_WINE_VER}" --no-cache --rm -t ${NAME}:${VERSION} . &&
docker commit -a "Nemirtingas" "${container_name}" nemirtingas/${NAME}:${VERSION} &&
docker push nemirtingas/${NAME}:${VERSION} &&
docker rm "${container_name}"
