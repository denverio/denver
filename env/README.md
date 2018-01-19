# DEnv - Dockerized environment settings on Alpine Linux

_Env settings over ssh on Alpine Linux._

## Features

- SSHD enabled

## Run

### Print env configuration

```shell
sh .denver/bin/env printenv
```

### Build image

```shell
sh .denver/bin/env build
```

### Remove image

```shell
sh .denver/bin/env remove
```

### Open env

```shell
sh .denver/bin/env
```

### Start sshd service

```shell
sh .denver/bin/env start
```

Then access via ssh:

```shell
ssh denver@localhost -p 2222
```

_No password required._

### Stop sshd service

```shell
sh .denver/bin/env stop
```

## Configure

When executing the commands, we can configure the environment variables.

If any env variable is not set, the variable assumes the default:

```shell
DE_ENV_NETWORK_NAME=${DE_NETWORK_NAME:-"denver_net"}
DE_ENV_SCOPE=${DOCKER_ID_USER:-$USER}
DE_ENV_NAME=env
DE_ENV_SSH_PORT=2222
DE_ENV_VOLUME_APP="${DE_ROOT_VOLUME_APP:-$HOME}/env"
DE_ENV_VOLUME_WORKSPACE="$HOME/workspace"
DE_ENV_DEFAULT_COMMAND=env
```

Then, to run any command with env variables, try:

```shell
DE_ENV_NETWORK_NAME="mynet" \
DE_ENV_SCOPE=myscope \
DE_ENV_NAME=myenv \
DE_ENV_SSH_PORT=9000 \
DE_ENV_VOLUME_APP="$HOME/.my-env/env" \
DE_ENV_VOLUME_WORKSPACE="$HOME/code" \
DE_ENV_DEFAULT_COMMAND=ash \
sh .denver/bin/env
```

*IMPORTANT: If "DE_ENV_SCOPE" or "DE_ENV_NAME" is defined
in the build, then they must be the same as running any other command*
