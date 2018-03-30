FROM alpine:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Denver base (with some tools) on Alpine Linux"
ENTRYPOINT ["/bin/base_entrypoint"]
EXPOSE 22

COPY rootfs /

ARG NON_ROOT="denver"
ARG TIMEZONE="UTC"
ARG LOCALE="en_US.UTF-8"
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

ENV NON_ROOT=${NON_ROOT} \
    NON_ROOT_HOME="/home/${NON_ROOT}" \
    LANG=${LOCALE} \
    LANGUAGE=${LOCALE} \
    LC_ALL=${LOCALE}

RUN \
# build dependencies
  apk add --no-cache --virtual build-dep \
    tzdata && \
# denver dependencies
  apk add --no-cache --virtual denver-dep \
    curl openssh findutils grep bash zsh tmux jq git && \
# configure ssh
  ssh-keygen -A && \
# configure timezone
  cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
  echo "${TIMEZONE}" > /etc/TZ && \
# add non root user
  adduser -D -s /bin/zsh "${NON_ROOT}" && \
  passwd -d "${NON_ROOT}" && \
# add volume dir
  mkdir -p /denver && \
  mkdir -p /workdir && \
# install oh-my-zsh
  git clone \
    --quiet \
    --depth=1 \
    --single-branch \
    -b master \
    https://github.com/robbyrussell/oh-my-zsh.git \
    "${NON_ROOT_HOME}/.oh-my-zsh" && \
# install tpm
  git clone \
    --quiet \
    --depth=1 \
    --single-branch \
    -b master \
    https://github.com/tmux-plugins/tpm.git \
    "${NON_ROOT_HOME}/.tpm" && \
# user permission
  chown -R 1000:1000 "${NON_ROOT_HOME}" && \
  chown -R 1000:1000 /denver && \
  chown -R 1000:1000 /workdir && \
# cleanup
  apk del build-dep

USER 1000
WORKDIR /workdir

ENV USER=${NON_ROOT} \
    HOME=${NON_ROOT_HOME} \
    TERM=xterm-256color \
    DENVER_HOME=/denver \
    DENVER_CONFIG="${DENVER_HOME}/.config"

RUN \
# user configs
  git config --global user.name "${GIT_USER_NAME}" && \
  git config --global user.email "${GIT_USER_EMAIL}" && \
  git config --global include.path "${DENVER_CONFIG}/git/.gitconfig"

VOLUME ["/denver", "/workdir"]
CMD ["tmux"]
