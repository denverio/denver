FROM ubuntu:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Denver base (with some tools) on Ubuntu Linux"
ENTRYPOINT ["/bin/base_entrypoint"]
EXPOSE 22

ARG TZ="UTC"
ARG LOCALE="C.UTF-8"
ARG GIT_USER_NAME
ARG GIT_USER_EMAIL

ENV USER="root" \
    HOME="/root" \
    TERM=xterm-256color \
    DENVER_HOME="/denver" \
    DENVER_CONFIG="/denver/.config" \
    TZ=${TZ} \
    LANG=${LOCALE} \
    LANGUAGE=${LOCALE} \
    LC_ALL=${LOCALE} \
    DIND_COMMIT=3b5fac462d21ca164b3778647420016315289034

RUN \
# denver dependencies
  apt-get update && \
  apt-get install -y \
    --no-install-recommends \
    alpine \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    jq \
    software-properties-common \
    ssh \
    sudo \
    tmux \
    wget \
    zsh && \
# install docker in docker
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | apt-key add - && \
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" && \
  apt-get update && \
  apt-get install -y \
    docker-ce && \
  # wget -O /usr/local/bin/dind \
    # "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind" && \
  # chmod +x /usr/local/bin/dind && \
# configure zsh for root
  chsh -s /bin/zsh root && \
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
    "${HOME}/.oh-my-zsh" && \
# install tpm
  git clone \
    --quiet \
    --depth=1 \
    --single-branch \
    -b master \
    https://github.com/tmux-plugins/tpm.git \
    "${HOME}/.tpm" && \
# git configs
  git config --global user.name "${GIT_USER_NAME}" && \
  git config --global user.email "${GIT_USER_EMAIL}" && \
  git config --global init.templatedir "${DENVER_CONFIG}/git/git_template" && \
  git config --global core.excludesfile "${DENVER_CONFIG}/git/.gitignore" && \
  git config --global include.path "${DENVER_CONFIG}/git/.gitconfig" && \
# cleanup
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY rootfs /
WORKDIR /workdir
VOLUME ["/denver", "/workdir"]
CMD ["tmux"]
