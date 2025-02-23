ARG UBUNTU_VERSION=22.04
ARG NODE_VERSION=v22.1.0
ARG JAVA_VERSION=17
ARG CMAKE_VERSION=3.22.1
ARG ANDROID_BUILD_TOOLS_VERSION=34.0.0
ARG ANDROID_NDK_VERSION=26.1.10909125

FROM ubuntu:${UBUNTU_VERSION}
WORKDIR /tmp
USER root

ONBUILD ARG NODE_VERSION
ONBUILD ARG JAVA_VERSION
ONBUILD ARG CMAKE_VERSION
ONBUILD ARG ANDROID_BUILD_TOOLS_VERSION
ONBUILD ARG ANDROID_NDK_VERSION

RUN apt-get update -y && apt-get install -yq curl git unzip wget

## Node + Bun

ONBUILD ENV NODE_VERSION=$NODE_VERSION

ENV NVM_DIR=/usr/local/nvm
RUN mkdir -p $NVM_DIR

ONBUILD RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION && nvm use $NODE_VERSION

ONBUILD ENV NODE_PATH=$NVM_DIR/versions/node/$NODE_VERSION
ONBUILD ENV PATH=$NODE_PATH/bin:$PATH

ONBUILD RUN npm i -g npm bun

ENV BUN_INSTALL=/root/.bun
ENV PATH=$BUN_INSTALL/bin:$PATH

ONBUILD RUN bun i -g eas-cli

## Java SDK

ONBUILD ENV JAVA_VERSION=$JAVA_VERSION

ONBUILD ENV JAVA_HOME=/usr/lib/jvm/jdk-${JAVA_VERSION}-oracle-x64
ONBUILD ENV PATH=$JAVA_HOME/bin:$PATH

RUN apt-get install -yq libc6-x32 libc6-i386 wget
ONBUILD RUN wget "https://download.oracle.com/java/${JAVA_VERSION}/latest/jdk-${JAVA_VERSION}_linux-x64_bin.deb" && dpkg -i "jdk-${JAVA_VERSION}_linux-x64_bin.deb"

ONBUILD RUN ln -s $(dirname $(dirname $(readlink -f $(which java)))) $JAVA_HOME

## Android SDK

ONBUILD ENV CMAKE_VERSION=$CMAKE_VERSION
ONBUILD ENV ANDROID_BUILD_TOOLS_VERSION=$ANDROID_BUILD_TOOLS_VERSION
ONBUILD ENV ANDROID_NDK_VERSION=$ANDROID_NDK_VERSION

ENV ANDROID_HOME=/usr/lib/android-sdk
ENV ANDROID_NDK_HOME=/usr/lib/android-sdk
RUN mkdir -p $ANDROID_HOME

RUN apt-get install -yq sdkmanager

ONBUILD RUN sdkmanager --install "cmake;${CMAKE_VERSION}"
ONBUILD RUN sdkmanager --install "build-tools;${ANDROID_BUILD_TOOLS_VERSION}"
ONBUILD RUN sdkmanager --install "ndk;${ANDROID_NDK_VERSION}"
RUN yes | sdkmanager --licenses

##

WORKDIR /
