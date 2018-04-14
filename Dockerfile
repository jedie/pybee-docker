#
# https://hub.docker.com/r/jedie/pybee/
#
FROM jedie/pybee:latest

#
#__________________________________________________________________________________________________
# Setup user
#

ARG	DOCKER_UID

RUN set -x && \
	addgroup -g ${DOCKER_UID} -S bee && \
	adduser -u ${DOCKER_UID} -D -S -G bee bee

USER bee
VOLUME /home/bee/
WORKDIR /home/bee/

RUN set -x && \
    mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg