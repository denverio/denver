FROM alpine:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Minimal sshd on Alpine Linux"
ENTRYPOINT ["/bin/ssh_entrypoint"]
EXPOSE 22
COPY rootfs /

ENV DE_SSHD_VERSION 0.0.1

RUN \
  sed -i -e 's/dl-cdn/dl-4/' /etc/apk/repositories && \
  apk add --no-cache openssh && \
  sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && \
  ssh-keygen -A && \
  echo "root:root" | chpasswd
