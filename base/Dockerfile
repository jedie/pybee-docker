#
# https://docs.docker.com/engine/reference/builder/
#
# https://voc.readthedocs.io/en/latest/background/install.html
#
# https://hub.docker.com/_/python/
FROM python:3.6-alpine

MAINTAINER Jens Diemer "https://github.com/jedie/pybee-docker"

# prepare
RUN set -ex && \
    umask 0002 && \
    apk --no-cache upgrade && \
    apk add --no-cache git ca-certificates wget unzip && \
    rm -rf /var/cache/apk/* && \
    pip3 install --no-cache-dir --upgrade pip

#
#__________________________________________________________________________________________________
# Install Java 8
# borrowed from: https://github.com/docker-library/openjdk/blob/master/8-jdk/alpine/Dockerfile
#
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH ${PATH}:${JAVA_HOME}/jre/bin:${JAVA_HOME}/bin
RUN set -ex && \
    apk add --no-cache openjdk8 && \
    rm -rf /var/cache/apk/* && \
    javac -version


#
#__________________________________________________________________________________________________
# Install gradle - https://gradle.org/install/
#
ENV GRADLE_VERSION 4.6
ENV GRADLE_HOME /opt/gradle-${GRADLE_VERSION}
ENV PATH ${PATH}:${GRADLE_HOME}/bin
RUN set -ex && \
    cd /tmp && \
    wget --no-verbose -O gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" && \
    unzip gradle.zip && \
    rm gradle.zip && \
    mkdir -p ${GRADLE_HOME} && \
    mv "gradle-${GRADLE_VERSION}/" /opt && \
    gradle --version


#
#__________________________________________________________________________________________________
# Install Apache Ant
# borrowed from: https://github.com/webratio/docker/blob/master/ant/1.10.1/Dockerfile
#
# Version Number: https://www.apache.org/dist/ant/binaries/?C=M;O=A
ENV ANT_VERSION 1.10.3
ENV ANT_HOME /opt/apache-ant-${ANT_VERSION}
ENV PATH ${PATH}:${ANT_HOME}/bin

RUN set -ex && \
    cd /tmp && \
    wget --no-verbose -O apache-ant-bin.tar.gz https://www.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-bin.tar.gz && \
    rm apache-ant-bin.tar.gz && \
    mv "apache-ant-${ANT_VERSION}/" /opt && \
    ant -version


#
#__________________________________________________________________________________________________
# Install nodejs and npm
#

RUN set -ex && \
    apk add --no-cache git nodejs && \
    rm -rf /var/cache/apk/* && \
    npm install -g npm && \
    npm --version && \
    node --version



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
    unzip -q android-sdk.zip && \
    rm android-sdk.zip && \
    mv tools ${ANDROID_HOME} && \
    chmod 777 ${ANDROID_HOME}/bin/* && \
    ls -la ${ANDROID_HOME}/bin && \
    mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg && \
    yes | sdkmanager --licenses | grep license && \
    sdkmanager --update && \
    sdkmanager --list


#
#__________________________________________________________________________________________________
# Install VOC - https://github.com/pybee/voc
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
# Install Briefcase - https://github.com/pybee/briefcase
#
RUN set -ex && \
    cd /opt && \
    git clone --depth=5 https://github.com/pybee/briefcase.git && \
    cd briefcase && \
    pip install -e .

#
#__________________________________________________________________________________________________
# Install Toga - https://github.com/pybee/toga
#
RUN set -ex && \
    cd /opt && \
    git clone --depth=5 https://github.com/pybee/toga.git && \
    pip install -e toga/src/core && \
    pip install -e toga/src/dummy && \
    pip install -e toga/src/django && \
    pip install -e toga/src/android
