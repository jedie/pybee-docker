#
# https://docs.docker.com/engine/reference/builder/
#
# https://voc.readthedocs.io/en/latest/background/install.html
#
# https://hub.docker.com/_/python/
FROM python:3.6-alpine


# prepare
RUN set -ex && \
    apk add --no-cache git ca-certificates wget


#
#__________________________________________________________________________________________________
# Install Java 8
# borrowed from: https://github.com/docker-library/openjdk/blob/master/8-jdk/alpine/Dockerfile
#
RUN set -ex && \
    apk add --no-cache openjdk8

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH ${PATH}:${JAVA_HOME}/jre/bin:${JAVA_HOME}/bin


#
#__________________________________________________________________________________________________
# Install Apache Ant
# borrowed from: https://github.com/webratio/docker/blob/master/ant/1.10.1/Dockerfile
#
# Version Number: https://www.apache.org/dist/ant/binaries/?C=M;O=A
ENV ANT_VERSION 1.10.2
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:${ANT_HOME}/bin

RUN set -ex && \
    cd /tmp && \
    wget --no-verbose https://www.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mkdir /opt && \
    mv apache-ant-${ANT_VERSION} ${ANT_HOME}


#
#__________________________________________________________________________________________________
# Install nodejs and npm
#

RUN set -ex \
    && apk add --no-cache git nodejs \
&& npm install -g npm


#
#__________________________________________________________________________________________________
# Install Android SDK
#

# Latest version number on:
# https://developer.android.com/studio/index.html
# under: "Get just the command line tools"
ENV SDK_TOOLS_VERSION=3859397
ENV ANDROID_HOME /opt/android
ENV PATH ${PATH}:${ANDROID_HOME}/bin

RUN set -ex && \
    cd /tmp && \
    wget --no-verbose -O android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS_VERSION}.zip && \
    cd /tmp && \
    ls -la && \
    unzip android-sdk.zip && \
    rm android-sdk.zip && \
    mv tools ${ANDROID_HOME} && \
    ls -la ${ANDROID_HOME}/bin && \
    yes | sdkmanager --licenses > /dev/null && \
    sdkmanager --update && \
    sdkmanager --list


#
#__________________________________________________________________________________________________
# Setup user
#

ARG	USER_ID=1000

RUN set -x \
	&& addgroup -g ${USER_ID} -S bee \
	&& adduser -u ${USER_ID} -D -S -G bee bee

WORKDIR /home/bee/


RUN set -ex && \
    pip3 install --no-cache-dir --upgrade pip


#
#__________________________________________________________________________________________________
# Install VOC
#

RUN set -ex && \
    cd /opt && \
    git clone --depth=5 https://github.com/pybee/voc.git && \
    cd voc && \
    pip install -e . && \
    ant java && \
    ls -la dist

ENV PYTHON_JAVA_SUPPORT_JAR=/opt/voc/dist/python-java-support.jar

#
#__________________________________________________________________________________________________
# build a "Hello World"
# https://voc.readthedocs.io/en/latest/tutorial/tutorial-0.html
#
RUN set -ex && \
    mkdir -p /tmp/voc_tutorial0 && \
    cd /tmp/voc_tutorial0 && \
    echo "print('Hello World!')">example.py && \
    voc -v example.py && \
    java -classpath ${PYTHON_JAVA_SUPPORT_JAR}:. python.example && \
    cd /home/bee/ && \
    rm -Rf /tmp/voc_tutorial0
