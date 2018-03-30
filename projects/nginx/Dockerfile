FROM nginx:stable-alpine
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Nginx with CA on Alpine Linux"
ENTRYPOINT ["/bin/nginx_entrypoint"]
EXPOSE 80
EXPOSE 443
COPY rootfs /
