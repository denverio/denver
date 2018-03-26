FROM alpine:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Minimal base on Alpine Linux"
ENTRYPOINT ["/bin/base_entrypoint"]
EXPOSE 22

COPY rootfs /

ARG NON_ROOT="denver"
ARG TIMEZONE="UTC"
ARG LOCALE="en_US.UTF-8"
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

ENV NON_ROOT_HOME "/home/${NON_ROOT}"
ENV LANG ${LOCALE}
ENV LANGUAGE ${LOCALE}
ENV LC_ALL ${LOCALE}

RUN \
# build dependencies
  apk add --no-cache --virtual build-dep \
    tzdata && \
# denver dependencies
  apk add --no-cache --virtual denver-dep \
    curl openssh findutils grep sudo bash jq git && \
# configure timezone
  cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
  echo "${TIMEZONE}" > /etc/TZ && \
# configure ssh
  ssh-keygen -A && \
# add user
  adduser -D -s /bin/bash "${NON_ROOT}" && \
  passwd -d "${NON_ROOT}" && \
  touch "${NON_ROOT_HOME}/.bashrc" && \
  mkdir "${NON_ROOT_HOME}/.ssh" && \
  touch "${NON_ROOT_HOME}/.ssh/authorized_keys" && \
  chown -R 1000:1000 "${NON_ROOT_HOME}" && \
  printf "\n${NON_ROOT} ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers && \
# add volume dir
  mkdir -p /workdir && \
  mkdir -p /app && \
  chown -R 1000:1000 /workdir && \
  chown -R 1000:1000 /app && \
# cleanup
  apk del build-dep

USER 1000
WORKDIR /workdir

ENV USER $NON_ROOT
ENV HOME $NON_ROOT_HOME

RUN \
# user configs
  git config --global user.name "${GIT_USER_NAME}" && \
  git config --global user.email "${GIT_USER_EMAIL}" && \
  git config --global include.path "/workdir/.env/git/.gitconfig"

VOLUME ["/workdir", "/app"]
