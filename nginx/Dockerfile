FROM denverio/env:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Nginx with CA and ssh on Alpine Linux"
ENTRYPOINT ["/bin/nginx_entrypoint"]
EXPOSE 80
EXPOSE 443
COPY rootfs /

ENV DE_NGINX_VERSION 0.0.1

RUN \
  sudo mkdir -p /run/nginx && \
  sudo apk add --no-cache nginx && \
# ensures env variables on ssh login
  env | sed -En "s/^(DE_NGINX_)/export\ \1/p" | sudo tee -a /etc/profile

# copy after install nginx
COPY rootfs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
