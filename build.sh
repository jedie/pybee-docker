#!/usr/bin/env bash

IMAGE_NAME=local:pybee
DOCKER_UID=$(id -u)
DOCKER_UGID=$(id -g)

set -xe

docker build \
    --build-arg DOCKER_UID=${DOCKER_UID} \
    --tag ${IMAGE_NAME} \
    .