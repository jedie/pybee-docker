#
# https://hub.docker.com/r/jedie/pybee/
#
FROM jedie/pybee:latest

#
#__________________________________________________________________________________________________
# Setup user
#

#ARG	USER_ID=1000
#
#RUN set -x && \
#	addgroup -g ${USER_ID} -S bee && \
#	adduser -u ${USER_ID} -D -S -G bee bee

USER bee
VOLUME /home/bee/
WORKDIR /home/bee/