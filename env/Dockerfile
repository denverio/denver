FROM denverio/sshd:latest
MAINTAINER Fiuza <fiuzagr@gmail.com>
LABEL description="Env settings over ssh on Alpine Linux"
ENTRYPOINT ["/bin/env_entrypoint"]
COPY rootfs /

ENV DE_ENV_VERSION 0.0.1

# Optional arguments
ARG TIMEZONE
ARG USER
ARG PASS

ENV DE_ENV_TZ ${TIMEZONE:-UTC}
ENV DE_ENV_USER ${USER:-denver}
ENV DE_ENV_HOME /home/${DE_ENV_USER}

RUN \
# configure user
  apk add --no-cache sudo tzdata && \
  echo "${DE_ENV_USER} ALL=(ALL) NOPASSWD:ALL" \
    | tee -a /etc/sudoers && \
  adduser -h ${DE_ENV_HOME} -u 1000 -D ${DE_ENV_USER} -s /bin/ash && \
  # echo "${DE_ENV_USER}:${PASS:-$DE_ENV_USER}" \
    # | chpasswd && \
  passwd -d ${DE_ENV_USER} && \
  sed -i s/#PermitEmptyPasswords.*/PermitEmptyPasswords\ yes/ \
    /etc/ssh/sshd_config && \
  sed -i s/#PermitUserEnvironment.*/PermitUserEnvironment\ yes/ \
    /etc/ssh/sshd_config && \
  mkdir ${DE_ENV_HOME}/.ssh && \
  touch ${DE_ENV_HOME}/.ssh/authorized_keys && \
  chown -R ${DE_ENV_USER}:${DE_ENV_USER} ${DE_ENV_HOME} && \
# ensures env variables on ssh login
  env | sed -En "s/^(DE_ENV_)/export\ \1/p" | tee -a /etc/profile && \
# configure timezone
  cp /usr/share/zoneinfo/${DE_ENV_TZ} /etc/localtime && \
  echo "${DE_ENV_TZ}" > /etc/TZ && \
# cleanup
  apk del tzdata

USER ${DE_ENV_USER}
WORKDIR ${DE_ENV_HOME}
