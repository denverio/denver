FROM denverio/env:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="{{description}}"
ENTRYPOINT ["/bin/{{snakeCase name}}_entrypoint"]
COPY rootfs /

ENV DE_{{constantCase name}}_VERSION 0.0.1

RUN \
  sudo sed -i -e 's/dl-cdn/dl-4/' /etc/apk/repositories && \
  sudo apk add --update
