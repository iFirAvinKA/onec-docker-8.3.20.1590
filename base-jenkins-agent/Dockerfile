ARG DOCKER_USERNAME
ARG ONEC_VERSION

FROM ${DOCKER_USERNAME}/onec-client-vnc-jenkins:${ONEC_VERSION}

# Installing mono and oscript dependencies
ARG MONO_VERSION=5.20.1.34

RUN apt-get update \
  && apt-get install -y --no-install-recommends gnupg dirmngr \
  && rm -rf /var/lib/apt/lists/* \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && gpg --batch --export --armor 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF > /etc/apt/trusted.gpg.d/mono.gpg.asc \
  && gpgconf --kill all \
  && rm -rf "$GNUPGHOME" \
  && apt-key list | grep Xamarin \
  && apt-get purge -y --auto-remove gnupg dirmngr

RUN echo "deb http://download.mono-project.com/repo/debian stable-stretch/snapshots/${MONO_VERSION} main" > /etc/apt/sources.list.d/mono-official-stable.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    mono-runtime \
    libmono-i18n4.0-all \
    libmono-system-runtime-serialization4.0-cil \
  && rm -rf  \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
    /tmp/*

# Installing oscript
ARG OVM_REPOSITORY_OWNER=nixel2007
ARG OVM_VERSION=1.0.0-RC12
ARG ONESCRIPT_VERSION=stable

RUN wget https://github.com/${OVM_REPOSITORY_OWNER}/ovm/releases/download/v${OVM_VERSION}/ovm.exe \
  && mv ovm.exe /usr/local/bin/ \
  && echo 'mono /usr/local/bin/ovm.exe "$@"' | tee /usr/local/bin/ovm \
  && chmod +x /usr/local/bin/ovm \
  && ovm use --install ${ONESCRIPT_VERSION}

ENV OSCRIPTBIN=/root/.local/share/ovm/current/bin
ENV PATH="$OSCRIPTBIN:$PATH"

# Update and prepare oscript packages
RUN opm install opm \
  && opm update --all \
  && opm install \
    add \
    gitsync \
    vanessa-runner \
  && gitsync plugins init \
  && gitsync plugins enable limit \
  && gitsync plugins disable limit

# Installing additional dependencies
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    cifs-utils \
    inetutils-ping \
    scrot \
  && rm -rf /var/lib/apt/lists/*

RUN echo 'scrot "${@:2}"' | tee /usr/local/bin/nircmd \
  && chmod +x /usr/local/bin/nircmd \
  && rm -rf /etc/services.d/onec

EXPOSE 5900
