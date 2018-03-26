FROM denver/base:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="NODE (with nvm) on Alpine Linux"

USER 0
COPY rootfs /

RUN \
# node dependencies
  apk add --no-cache --virtual node-dep \
    nodejs python2 make gcc

USER 1000
ENTRYPOINT ["/bin/node_entrypoint"]
WORKDIR /workdir
VOLUME ["/workdir", "/app"]
