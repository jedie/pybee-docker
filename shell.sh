#!/usr/bin/env bash

IMAGE_NAME=pybee

PYBEE_DOCKER_HOME=~/.pybee-docker
mkdir -p ${PYBEE_DOCKER_HOME}

if [[ "$*" == "" ]]; then
    # no agrument given: start shell
    args=/bin/ash
else
    args=$*
fi

set -xe

docker run -it --rm \
    --user=${UID:-1000} \
	-v /tmp:/tmp \
	-v ${PYBEE_DOCKER_HOME}:/home/bee \
    ${IMAGE_NAME} \
    ${args}