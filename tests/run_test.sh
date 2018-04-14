#!/usr/bin/env bash

#
# run a test in the docker container
#
# e.g.:
#   pybee-docker$ cd tests
#   pybee-docker/tests$ ./run_test.sh test_voc_turorial0.sh
#

DOCKER_UID=$(id -u)
DOCKER_UGID=$(id -g)

BASE_DIR="$( dirname $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ))"

ARGS="/bin/ash tests/${1}"

(
    set -x
    docker run -t \
        --user=${DOCKER_UID}:${DOCKER_UGID} \
        -v ${BASE_DIR}:/home/bee \
        local:pybee \
        ${ARGS}
)