# {{title}}

_{{description}}_

{{#if features}}
## Features

{{#each features}}
- {{this}}
{{/each}}
{{/if}}

## Run

### Print env configuration

```shell
sh .denver/bin/{{snakeCase name}} printenv
```

### Build image

```shell
sh .denver/bin/{{snakeCase name}} build
```

### Remove image

```shell
sh .denver/bin/{{snakeCase name}} remove
```

{{#unless sshd}}
### Open {{name}}

```shell
sh .denver/bin/{{snakeCase name}}
```
{{/unless}}

### Start sshd service

```shell
sh .denver/bin/{{snakeCase name}} start
```

Then access via ssh:

{{#if sshd}}
```shell
ssh root@localhost -p 2222
```

_Default password is **root**._
{{else}}
```shell
ssh denver@localhost -p 2222
```

_No password required._
{{/if}}

### Stop sshd service

```shell
sh .denver/bin/{{snakeCase name}} stop
```

## Configure

When executing the commands, we can configure the environment variables.

If any env variable is not set, the variable assumes the default:

```shell
DE_{{constantCase name}}_NETWORK_NAME=${DE_NETWORK_NAME:-"denver_net"}
DE_{{constantCase name}}_SCOPE=${DOCKER_ID_USER:-$USER}
DE_{{constantCase name}}_NAME={{snakeCase name}}
DE_{{constantCase name}}_SSH_PORT=2222
DE_{{constantCase name}}_VOLUME_APP="$HOME/.{{dashCase name}}"
DE_{{constantCase name}}_VOLUME_WORKSPACE="$HOME/workspace"
DE_{{constantCase name}}_DEFAULT_COMMAND={{snakeCase name}}
```

Then, to run any command with env variables, try:

```shell
DE_{{constantCase name}}_NETWORK_NAME="mynet" \
DE_{{constantCase name}}_SCOPE=myscope \
DE_{{constantCase name}}_NAME=my{{snakeCase name}} \
DE_{{constantCase name}}_SSH_PORT=9000 \
DE_{{constantCase name}}_VOLUME_APP="$HOME/.my-env/{{dashCase name}}" \
DE_{{constantCase name}}_VOLUME_WORKSPACE="$HOME/code" \
DE_{{constantCase name}}_DEFAULT_COMMAND=ash \
sh .denver/bin/{{snakeCase name}}
```

*IMPORTANT: If "DE_{{constantCase name}}_SCOPE" or "DE_{{constantCase name}}_NAME" is defined
in the build, then they must be the same as running any other command*
