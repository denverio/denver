FROM denver/base:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="TMUX (with tmux tpm) on Alpine Linux"
ENTRYPOINT ["/bin/tmux_entrypoint"]

USER 0
COPY rootfs /

RUN \
# install tmux
  apk add --no-cache tmux && \
# install tpm
  git clone \
    --quiet \
    --depth=1 \
    --single-branch \
    -b master \
    https://github.com/tmux-plugins/tpm.git \
    /tmux-tpm && \
# tmux.conf
  ln -s /.tmux.conf /home/denver/.tmux.conf && \
  ln -s /.tmux.conf /root/.tmux.conf && \
# 
  printf "\n\
if [[ \$TMUX ]]\n\
then\n\
  ssh denver@zsh.denver -oStrictHostKeyChecking=no -q\n\
  exit 0\n\
fi\n" | tee -a /etc/profile

USER 1000
WORKDIR /workdir
