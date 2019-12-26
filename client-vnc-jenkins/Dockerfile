ARG DOCKER_USERNAME
ARG ONEC_VERSION

FROM ${DOCKER_USERNAME}/onec-client-vnc:${ONEC_VERSION}

LABEL maintainer="Nikita Gryzlov <NikGryzlov@1bit.com>, FirstBit"

# Install OpenJDK and additional Jenkins dependencies
ARG OPENJDK_VERSION=13

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      apt-transport-https \
      ca-certificates \
      gnupg \
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
  && rm -rf  \
    /var/lib/apt/lists/* \
    /var/cache/debconf

RUN chmod 755 /init
