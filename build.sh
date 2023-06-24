#! /bin/bash

NAME=breakpad_dump_syms
VERSION=latest

container_name="$(mktemp -u XXXXXXXXXXXX)"

docker build --no-cache --rm -t ${NAME}:${VERSION} . &&
docker run "--name=${container_name}" ${NAME}:${VERSION} /bin/bash -c exit &&
docker commit -a "Nemirtingas" "${container_name}" nemirtingas/${NAME}:${VERSION} &&
docker push nemirtingas/${NAME}:${VERSION} &&
docker rm "${container_name}"
