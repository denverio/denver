FROM denverio/env:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="{{description}}"
ENTRYPOINT ["/bin/{{snakeCase name}}_entrypoint"]
COPY rootfs /

ENV DE_{{constantCase name}}_VERSION 0.0.1

RUN \
  sudo apk add --no-cache ash && \
# ensures env variables on ssh login
  env | sed -En "s/^(DE_{{constantCase name}}_)/export\ \1/p" | sudo tee -a /etc/profile
