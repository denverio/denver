# DBash - Dockerized bash on Alpine Linux

_Bash (with bash-it) over ssh on Alpine Linux._

## Features

- Bash-it preconfigured
- SSHD enabled

## Run

### Print env configuration

```shell
sh .denver/bin/bash printenv
```

### Build image

```shell
sh .denver/bin/bash build
```

### Remove image

```shell
sh .denver/bin/bash remove
```

### Open bash

```shell
sh .denver/bin/bash
```

### Start sshd service

```shell
sh .denver/bin/bash start
```

Then access via ssh:

```shell
ssh denver@localhost -p 2222
```

_No password required._

### Stop sshd service

```shell
sh .denver/bin/bash stop
```

## Configure

When executing the commands, we can configure the environment variables.

If any env variable is not set, the variable assumes the default:

```shell
DE_BASH_NETWORK_NAME=${DE_NETWORK_NAME:-"denver_net"}
DE_BASH_SCOPE=${DOCKER_ID_USER:-$USER}
DE_BASH_NAME=bash
DE_BASH_SSH_PORT=2222
DE_BASH_VOLUME_APP="$HOME/.bash"
DE_BASH_VOLUME_WORKSPACE="$HOME/workspace"
DE_BASH_DEFAULT_COMMAND=bash
```

Then, to run any command with env variables, try:

```shell
DE_BASH_NETWORK_NAME="mynet" \
DE_BASH_SCOPE=myscope \
DE_BASH_NAME=mybash \
DE_BASH_SSH_PORT=9000 \
DE_BASH_VOLUME_APP="$HOME/.my-env/bash" \
DE_BASH_VOLUME_WORKSPACE="$HOME/code" \
DE_BASH_DEFAULT_COMMAND=ash \
sh .denver/bin/bash
```

*IMPORTANT: If "DE_BASH_SCOPE" or "DE_BASH_NAME" is defined
in the build, then they must be the same as running any other command*
