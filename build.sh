#!/usr/bin/env bash

IMAGE_NAME=local:pybee

set -xe

docker build \
    --build-arg USER_ID=${UID:-1000} \
    --tag ${IMAGE_NAME} \
    .