# DCa - Dockerized Certificate Authority Generator

_Generates Certificate Authority_


## Run

### Print env configuration

```shell
sh .denver/bin/ca printenv
```

### Build image

```shell
sh .denver/bin/ca build
```

### Remove image

```shell
sh .denver/bin/ca remove
```

### Generate a new certificate

```shell
sh .denver/bin/ca generate
```

### Open ca

```shell
sh .denver/bin/ca
```

## Configure

When executing the commands, we can configure the environment variables.

If any env variable is not set, the variable assumes the default:

```shell
DE_CA_NETWORK_NAME=${DE_NETWORK_NAME:-"denver_net"}
DE_CA_SCOPE=${DOCKER_ID_USER:-$USER}
DE_CA_NAME=ca
DE_CA_VOLUME_APP="$HOME/.ca"
DE_CA_VOLUME_WORKSPACE="$HOME/workspace"
DE_CA_DEFAULT_COMMAND=ca
```

Then, to run any command with env variables, try:

```shell
DE_CA_NETWORK_NAME="mynet" \
DE_CA_SCOPE=myscope \
DE_CA_NAME=myca \
DE_CA_VOLUME_APP="$HOME/.my-env/ca" \
DE_CA_VOLUME_WORKSPACE="$HOME/code" \
DE_CA_DEFAULT_COMMAND=ash \
sh .denver/bin/ca
```

*IMPORTANT: If "DE_CA_SCOPE" or "DE_CA_NAME" is defined
in the build, then they must be the same as running any other command*
