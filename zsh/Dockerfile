FROM denver/base:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="ZSH (with oh-my-zsh) on Alpine Linux"
ENTRYPOINT ["/bin/zsh_entrypoint"]

USER 0
COPY rootfs /

RUN \
# install zsh
  apk add --no-cache zsh && \
# set zsh for all users
  sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd && \
  sed -i -e "s/bin\/bash/bin\/zsh/" /etc/passwd && \
# install oh-my-zsh
  git clone \
    --quiet \
    --depth=1 \
    --single-branch \
    -b master \
    https://github.com/robbyrussell/oh-my-zsh.git \
    /.oh-my-zsh && \
  ln -s /.oh-my-zsh /home/denver/.oh-my-zsh && \
  ln -s /.oh-my-zsh /root/.oh-my-zsh && \
# zshrc
  ln -s /.zshrc /home/denver/.zshrc && \
  ln -s /.zshrc /root/.zshrc && \
# force command on ssh login
  printf "\n\
Match all\n\
  ForceCommand env sh -c -e \"cd /workdir; zsh\"\n\
" | tee -a /etc/ssh/sshd_config

USER 1000
WORKDIR /workdir
