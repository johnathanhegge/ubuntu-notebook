#FROM nimbix/ubuntu-base:trusty
FROM ubuntu:trusty
LABEL maintainer="Nimbix, Inc."

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20180124.1405}

ARG GIT_BRANCH
ENV GIT_BRANCH ${GIT_BRANCH:-testing}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/$GIT_BRANCH/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop --image-common-branch $GIT_BRANCH

#ADD help.html /etc/NAE/help.html
ADD AppDef.json /etc/NAE/AppDef.json

#ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
##Tornado >=1.2,<.2.0
#RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh

# for standalone use
EXPOSE 22
EXPOSE 5901
EXPOSE 443
