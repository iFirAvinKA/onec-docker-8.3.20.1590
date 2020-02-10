ARG DOCKER_USERNAME
ARG ONEC_VERSION
ARG BASE_IMAGE=onec-client-vnc

FROM ${DOCKER_USERNAME}/${BASE_IMAGE}:${ONEC_VERSION}

LABEL maintainer="Nikita Gryzlov <NikGryzlov@1bit.com>, FirstBit"

# Install OpenJDK and additional Jenkins dependencies
ARG OPENJDK_VERSION=13

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      gnupg \
      dirmngr \
      openssh-client \
      software-properties-common \
      wget \
  && wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
  && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \
  && apt-get update \
  # see https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199#23
  && mkdir -p /usr/share/man/man1 \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      adoptopenjdk-${OPENJDK_VERSION}-hotspot \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 \
  && echo "deb http://security.ubuntu.com/ubuntu xenial-security main" > /etc/apt/sources.list.d/xenial-security.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
     libpng12-0 \
  && rm -rf  \
    /var/lib/apt/lists/* \
    /var/cache/debconf

COPY ./base-jenkins-agent/docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh \
  && chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
