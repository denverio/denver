# DSshd - Dockerized minimal sshd on Alpine Linux

_Minimal sshd on Alpine Linux._


## Run

### Print env configuration

```shell
sh .denver/bin/sshd printenv
```

### Build image

```shell
sh .denver/bin/sshd build
```

### Remove image

```shell
sh .denver/bin/sshd remove
```


### Start sshd service

```shell
sh .denver/bin/sshd start
```

Then access via ssh:

```shell
ssh root@localhost -p 2222
```

_Default password is **root**._

### Stop sshd service

```shell
sh .denver/bin/sshd stop
```

## Configure

When executing the commands, we can configure the environment variables.

If any env variable is not set, the variable assumes the default:

```shell
DE_SSHD_NETWORK_NAME=${DE_NETWORK_NAME:-"denver_net"}
DE_SSHD_SCOPE=${DOCKER_ID_USER:-$USER}
DE_SSHD_NAME=sshd
DE_SSHD_SSH_PORT=2222
DE_SSHD_VOLUME_APP="${DE_ROOT_VOLUME_APP:-$HOME}/sshd"
DE_SSHD_VOLUME_WORKSPACE="$HOME/workspace"
DE_SSHD_DEFAULT_COMMAND=sshd
```

Then, to run any command with env variables, try:

```shell
DE_SSHD_NETWORK_NAME="mynet" \
DE_SSHD_SCOPE=myscope \
DE_SSHD_NAME=mysshd \
DE_SSHD_SSH_PORT=9000 \
DE_SSHD_VOLUME_APP="$HOME/.my-env/sshd" \
DE_SSHD_VOLUME_WORKSPACE="$HOME/code" \
DE_SSHD_DEFAULT_COMMAND=ash \
sh .denver/bin/sshd
```

*IMPORTANT: If "DE_SSHD_SCOPE" or "DE_SSHD_NAME" is defined
in the build, then they must be the same as running any other command*
