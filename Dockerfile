FROM ubuntu:bionic
LABEL maintainer="Nimbix, Inc."

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20190214.160000}

ARG GIT_BRANCH
ENV GIT_BRANCH ${GIT_BRANCH:-bionic-new-vnc-vgl}

RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop --image-common-branch $GIT_BRANCH

ADD help.html /etc/NAE/help.html
ADD AppDef.json /etc/NAE/AppDef.json

ENV NB_BRANCH=master
ADD https://raw.githubusercontent.com/nimbix/notebook-common/$NB_BRANCH/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh

# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443
