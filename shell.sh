#!/usr/bin/env bash

IMAGE_NAME=local:pybee

PYBEE_DOCKER_HOME=~/.pybee-docker
mkdir -p ${PYBEE_DOCKER_HOME}

DOCKER_UID=$(id -u)
DOCKER_UGID=$(id -g)

if [[ "$*" == "" ]]; then
    # no agrument given: start shell
    args=/bin/ash
else
    args=$*
fi

set -xe

docker run -it --rm \
    --user=${DOCKER_UID}:${DOCKER_UGID} \
    -v /tmp:/tmp \
    -v ${PYBEE_DOCKER_HOME}:/home/bee \
    ${IMAGE_NAME} \
    ${args}