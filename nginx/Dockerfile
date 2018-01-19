FROM alpine:latest AS builder
COPY rootfs/local.ca.ext /local.ca.ext
RUN \
  mkdir /certs && \
  apk add --no-cache openssl && \
  openssl rand -base64 48 > /tmp/passphrase.txt && \
  openssl genrsa -des3 \
    -passout file:/tmp/passphrase.txt \
    -out /tmp/my.ca.key 2048 && \
  openssl req -x509 -new -nodes -sha256 \
    -days 3650 \
    -passin file:/tmp/passphrase.txt \
    -key /tmp/my.ca.key \
    -out /certs/my.ca.pem \
    -subj "/C=BR/ST=State/L=City/O=LocalDev Inc/OU=Dev/CN=LocalDev" && \
  openssl genrsa -out /certs/local.ca.key 2048 && \
  openssl req -new \
    -key /certs/local.ca.key \
    -out /certs/local.ca.csr \
    -subj "/C=BR/ST=State/L=City/O=LocalDev Inc/OU=Dev/CN=LocalDev Sites" && \
  openssl x509 -req -sha256 \
    -days 3650 \
    -passin file:/tmp/passphrase.txt \
    -in /certs/local.ca.csr \
    -out /certs/local.ca.crt \
    -CA /certs/my.ca.pem \
    -CAkey /tmp/my.ca.key \
    -CAcreateserial \
    -extfile /local.ca.ext


FROM denverio/env:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Nginx with CA and ssh on Alpine Linux"
ENTRYPOINT ["/bin/nginx_entrypoint"]
EXPOSE 80
EXPOSE 443
COPY rootfs /
COPY --from=builder /certs /certs

ENV DE_NGINX_VERSION 0.0.1

RUN \
  sudo mkdir -p /run/nginx && \
  sudo apk add --no-cache nginx && \
# ensures env variables on ssh login
  env | sed -En "s/^(DE_NGINX_)/export\ \1/p" | sudo tee -a /etc/profile

# copy after install nginx
COPY rootfs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
