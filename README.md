# DEPRECATED

This project is abandoned in favor of [Îagûara](https://github.com/iaguara/iaguara).

---

# Denver

_Creates development environment quickly using docker._


## Installing via script (Ubuntu only)

```shell
wget -qO- \
  https://raw.githubusercontent.com/fiuzagr/denver/master/install.sh | \
  env \
    DENVER_HOME="$HOME/.denver" \
    DENVER_BRANCH=master \
    sh
```


## Dependencies

- [Docker](https://www.docker.com/)


## Install

Clone this repository and insert the code below into your `.bashrc` or `.zshrc`.

```shell
export DENVER_HOME="$HOME/.denver"
[ -s "$DENVER_HOME/denver.sh" ] && \. $DENVER_HOME/denver.sh
```

Use the `.env.example` file to create `.env` file. Then, edit `.env` with your
configs.

```shell
cp .env.example .env
```

Install projects config files inside your denver home:

```shell
wget -qO- \
  https://raw.githubusercontent.com/fiuzagr/env/v2/install.sh | \
  env \
    ENV_HOME="$DENVER_HOME/.config" \
    ENV_BRANCH=v2 \
    sh
```

## Use

### Build project

```shell
denver build <project-name> [<build args>]
```

### Run project

```shell
denver <project-name> [<command>]
```

### Start project ssh

```shell
denver start <project-name> <github-user> [<another-github-user>...]
```

### Stop project container

```shell
denver stop <project-name>
```

### Remove project image

```shell
denver remove <project-name>
```

### Print configured environment

```shell
denver printenv [<project-name>]
```
