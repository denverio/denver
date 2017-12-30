FROM alpine/git:latest AS builder
RUN \
  git clone --depth 1 https://github.com/Bash-it/bash-it.git /bash_it && \
  rm -rf /bash_it/.git

FROM denverio/env:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Bash (with bash-it) over ssh on Alpine Linux"
ENTRYPOINT ["/bin/bash_entrypoint"]
COPY rootfs /
COPY --from=builder /bash_it /tmp/bash_it

ENV DE_BASH_VERSION 0.0.1

RUN \
# install bash
  sudo apk add --no-cache bash bash-completion && \
# set bash for all users
  sudo sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
# install bash-it
  cp -R /tmp/bash_it ${DE_ENV_HOME}/.bash_it && \
  ${DE_ENV_HOME}/.bash_it/install.sh --silent && \
# overwrite .bashrc
  mv ${DE_ENV_HOME}/.bashrc ${DE_ENV_HOME}/.bashrc.bkp && \
  sudo mv /.bashrc ${DE_ENV_HOME}/.bashrc && \
  sudo chown ${DE_ENV_USER}:${DE_ENV_USER} ${DE_ENV_HOME}/.bashrc && \
# load bashrc when the access is via ssh
  echo "[ -f ${DE_ENV_HOME}/.bashrc ] && source ${DE_ENV_HOME}/.bashrc" \
    | tee -a ${DE_ENV_HOME}/.bash_profile && \
# ensures env variables on ssh login
  env | sed -En "s/^(DE_BASH_)/export\ \1/p" | sudo tee -a /etc/profile && \
# force command on ssh login
  printf "\n\
Match User ${DE_ENV_USER}\n\
  ForceCommand env sh -c -e \"source /etc/profile; bash\"\n\
" | sudo tee -a /etc/ssh/sshd_config
