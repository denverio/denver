# DNginx - Dockerized nginx server

_Nginx with CA and ssh on Alpine Linux_

## Features

- SSHD enabled

## Run

### Print env configuration

```shell
sh .denver/bin/nginx printenv
```

### Build image

```shell
sh .denver/bin/nginx build
```

### Remove image

```shell
sh .denver/bin/nginx remove
```

### Open nginx

```shell
sh .denver/bin/nginx
```

### Start sshd service

```shell
sh .denver/bin/nginx start
```

Then access via ssh:

```shell
ssh denver@localhost -p 2222
```

_No password required._

### Stop sshd service

```shell
sh .denver/bin/nginx stop
```

## Configure

When executing the commands, we can configure the environment variables.

If any env variable is not set, the variable assumes the default:

```shell
DE_NGINX_NETWORK_NAME=${DE_NETWORK_NAME:-"denver_net"}
DE_NGINX_SCOPE=${DOCKER_ID_USER:-$USER}
DE_NGINX_NAME=nginx
DE_NGINX_SSH_PORT=2222
DE_NGINX_VOLUME_APP="$HOME/.nginx"
DE_NGINX_VOLUME_WORKSPACE="$HOME/workspace"
DE_NGINX_DEFAULT_COMMAND=nginx
```

Then, to run any command with env variables, try:

```shell
DE_NGINX_NETWORK_NAME="mynet" \
DE_NGINX_SCOPE=myscope \
DE_NGINX_NAME=mynginx \
DE_NGINX_SSH_PORT=9000 \
DE_NGINX_VOLUME_APP="$HOME/.my-env/nginx" \
DE_NGINX_VOLUME_WORKSPACE="$HOME/code" \
DE_NGINX_DEFAULT_COMMAND=ash \
sh .denver/bin/nginx
```

*IMPORTANT: If "DE_NGINX_SCOPE" or "DE_NGINX_NAME" is defined
in the build, then they must be the same as running any other command*
