FROM alpine:latest AS builder

ENV COMPILED_BY="fiuzagr"
ENV BUILD_DIR /tmp/vim
ENV INSTALL_DIR /vim
ENV VIM_FILES ${INSTALL_DIR}/usr/local/share/vim/vimfiles
ENV RUBY_COMMAND /usr/bin/ruby
ENV PYTHON_CONFIG_DIR /usr/lib/python2.7/config
ENV PYTHON3_CONFIG_DIR /usr/lib/python3.6/config-3.6m-x86_64-linux-gnu
ENV PACKAGES="\
  build-base \
  curl \
  git \
  gnupg \
  libffi \
  libffi-dev \
  libx11-dev \
  libxpm-dev \
  libxt-dev \
  lua-dev \
  luajit-dev \
  make \
  ncurses-dev \
  perl-dev \
  python-dev \
  python3-dev \
  ruby \
  ruby-dev \
  tar \
"

RUN \
  apk add --no-cache ${PACKAGES} && \
# install fpm
  gem update --no-ri --no-rdoc --system && \
  gem install --no-ri --no-rdoc fpm && \
# clone vim repo
  git clone --depth 1 \
    https://github.com/vim/vim ${BUILD_DIR} && \
  cd ${BUILD_DIR} && \
  VIM_VERSION=$(git describe --abbrev=0 --tags) && \
# configure installation
  ./configure \
    --with-features=huge \
    --with-x \
    --enable-cscope \
    --enable-multibyte \
    --enable-perlinterp=dynamic \
    --enable-rubyinterp=dynamic \
    --enable-pythoninterp=dynamic \
    --enable-python3interp \
    --enable-luainterp \
    --enable-fontset \
    --enable-largefile \
    --enable-fail-if-missing \
    --disable-gui \
    --disable-netbeans \
    --with-luajit \
    --with-ruby-command=${RUBY_COMMAND} \
    --with-python-config-dir=${PYTHON_CONFIG_DIR} \
    --with-python3-config-dir=${PYTHON3_CONFIG_DIR} \
    --with-compiledby=${COMPILED_BY} && \
# install on INSTALL_DIR
  rm -rf ${INSTALL_DIR} && \
  make && \
  make install DESTDIR=${INSTALL_DIR} && \
  cd ${INSTALL_DIR} && \
# install vim-plug
  mkdir -p ${VIM_FILES}/autoload && \
  chown -R 755 ${VIM_FILES} && \
  curl -fLo ${VIM_FILES}/autoload/plug.vim \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
# generate vim package
  fpm \
    --input-type dir \
    --output-type apk \
    --name vim \
    --version ${VIM_VERSION} \
    --no-auto-depends \
    --depends ctags \
    --depends git \
    --depends libice \
    --depends libsm \
    --depends libx11 \
    --depends libxt \
    --depends lua \
    --depends luajit \
    --depends ncurses \
    --depends perl \
    --depends python \
    --depends python3 \
    --depends ruby \
    . && \
  mv *.apk /

FROM denver/base:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Latest Vim from source (+python +python3 +ruby +lua +perl) with vim-plug on Alpine Linux"
ENTRYPOINT ["/bin/vim_entrypoint"]

USER 0
COPY rootfs /
COPY --from=builder /vim*.apk /tmp/vim.apk

RUN \
# install vim package
  apk add --no-cache --allow-untrusted /tmp/vim.apk && \
# create .vimrc file
  ln -s /.vimrc /home/denver/.vimrc && \
  ln -s /.vimrc /root/.vimrc && \
# force command on ssh login
  printf "\n\
Match all\n\
  ForceCommand env sh -c -e \"cd /workdir; vim\"\n\
" | tee -a /etc/ssh/sshd_config

USER 1000
WORKDIR /workdir
