# DVim - Dockerized latest vim from source

_Latest Vim from source (+python +python3 +ruby +lua +perl) with vim-plug over ssh on Alpine Linux._

## Features

- Support for python, python3, ruby, lua, perl
- Built-in vim-plug
- SSHD enabled

## Run

### Print env configuration

```shell
sh .denver/bin/vim printenv
```

### Build image

```shell
sh .denver/bin/vim build
```

### Remove image

```shell
sh .denver/bin/vim remove
```

### Open vim

```shell
sh .denver/bin/vim
```

### Start sshd service

```shell
sh .denver/bin/vim start
```

Then access via ssh:

```shell
ssh denver@localhost -p 2222
```

_No password required._

### Stop sshd service

```shell
sh .denver/bin/vim stop
```

## Configure

When executing the commands, we can configure the environment variables.

If any env variable is not set, the variable assumes the default:

```shell
DE_VIM_NETWORK_NAME=${DE_NETWORK_NAME:-"denver_net"}
DE_VIM_SCOPE=${DOCKER_ID_USER:-$USER}
DE_VIM_NAME=vim
DE_VIM_SSH_PORT=2222
DE_VIM_VOLUME_APP="${DE_ROOT_VOLUME_APP:-$HOME}/vim"
DE_VIM_VOLUME_WORKSPACE="$HOME/workspace"
DE_VIM_DEFAULT_COMMAND=vim
```

Then, to run any command with env variables, try:

```shell
DE_VIM_NETWORK_NAME="mynet" \
DE_VIM_SCOPE=myscope \
DE_VIM_NAME=myvim \
DE_VIM_SSH_PORT=9000 \
DE_VIM_VOLUME_APP="$HOME/.my-env/vim" \
DE_VIM_VOLUME_WORKSPACE="$HOME/code" \
DE_VIM_DEFAULT_COMMAND=ash \
sh .denver/bin/vim
```

*IMPORTANT: If "DE_VIM_SCOPE" or "DE_VIM_NAME" is defined
in the build, then they must be the same as running any other command*
