#!/usr/bin/env bash

IMAGE_NAME=jedie/pybee:latest

set -xe

docker build \
    --build-arg USER_ID=${UID:-1000} \
    --tag ${IMAGE_NAME} \
    .