FROM alpine:latest as downloader

ARG ONEC_USERNAME
ARG ONEC_PASSWORD
ARG ONEC_VERSION
ENV installer_type=server
#RUN echo $ONEC_VERSION

COPY ./scripts/download.sh /download.sh

WORKDIR /tmp

RUN apk --no-cache add bash curl grep \
   && chmod +x /download.sh \
   &&sync; /download.sh \
  && for file in *.tar.gz; do tar -zxf "$file"; done \
  && rm -rf *.tar.gz

FROM debian:bullseye-slim as base

ARG gosu_ver=1.11
ARG nls_enabled=false
ENV nls=$nls_enabled
ARG ONEC_VERSION
ENV FileInstaller="./setup-full-$ONEC_VERSION-x86_64.run"

#					setup-full-8.3.20.1590-x86_64.run

COPY --from=downloader /tmp/*.run /tmp/

WORKDIR /tmp

RUN set -xe \ 
  && apt-get update \
  && apt-get install \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      libgtk-3-0 libharfbuzz-icu0 libgstreamer1.0-0 htop libgstreamer-plugins-base1.0-0 \
	  gstreamer1.0-plugins-good gstreamer1.0-plugins-bad libsecret-1-0 libsoup2.4-1 \
	  libsqlite3-0 libegl1-mesa libxrender1 libxfixes3 libxslt1.1 geoclue-2.0 

#RUN echo $FileInstaller

RUN set -xe \ 
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl \ 
    && chmod +x $FileInstaller \
    && $FileInstaller --installer-language en --mode unattended --enable-components server \
    && rm $FileInstaller

# create symlink to current 1c: directory
COPY ./scripts/create-symlink-to-current-1cv8.sh /create-symlink-to-current-1cv8.sh
RUN chmod +x /create-symlink-to-current-1cv8.sh \
  && /create-symlink-to-current-1cv8.sh \
  && rm /create-symlink-to-current-1cv8.sh

ADD https://github.com/tianon/gosu/releases/download/$gosu_ver/gosu-amd64 /bin/gosu

RUN chmod +x /bin/gosu

FROM debian:bullseye-slim
LABEL maintainer="Anton Kvashenkin <anton.jugatsu@gmail.com> (@jugatsu)"

ARG ONEC_VERSION
ARG onec_uid="999"
ARG onec_gid="999"
#ENV Folder1C="/opt/1cv8/x86_64/$ONEC_VERSION/conf"

COPY --from=base /opt /opt
COPY --from=base /bin/gosu /bin/gosu

RUN set -xe \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends htop\
      locales \
      imagemagick \
      fontconfig \
  && rm -rf \
    /var/lib/apt/lists/* \
    /var/cache/debconf \
  && localedef -i ru_RU -c -f UTF-8 -A /usr/share/locale/locale.alias ru_RU.UTF-8
ENV LANG ru_RU.UTF-8

RUN groupadd -r grp1cv8 --gid=$onec_gid \
  && useradd -r -g grp1cv8 --uid=$onec_uid --home-dir=/home/usr1cv8 --shell=/bin/bash usr1cv8 \
  && mkdir -p /var/log/1C /home/usr1cv8/.1cv8/1C/1cv8/conf /opt/1cv8/x86_64/8.3.20.1590 \
  && chown -R usr1cv8:grp1cv8 /var/log/1C /home/usr1cv8

WORKDIR /opt/1cv8/x86_64/8.3.20.1590

VOLUME /home/usr1cv8/.1cv8 //f/Vol1c

COPY ./server/logcfg.xml /home/usr1cv8/.1cv8/1C/1cv8/conf
COPY ./server/logcfg.xml /opt/1cv8/x86_64/8.3.20.1590

COPY ./server/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]


EXPOSE 1540 1541 1560
CMD ["ragent"]