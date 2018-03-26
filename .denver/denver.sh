#!/usr/bin/env sh

rootPath=$(cd -P -- "$(dirname -- "$0")/.." && printf '%s\n' "$(pwd -P)")

export DENVER_HOME=${DENVER_HOME:-$rootPath}
export DENVER_BIN_PATH="$DENVER_HOME/.denver/bin"
export DENVER_RC="$DENVER_HOME/.denver/denver.sh"

env="$DENVER_BIN_PATH/env"
run="$DENVER_BIN_PATH/run"
help="$DENVER_BIN_PATH/help"

denver() {
  local command="$1"
  local file="$DENVER_BIN_PATH/$command"

  # remove first argument
  [ $# -ne 0 ] && shift

  {
    if [ -s "$file" ] 
    then
      # run file if exists
      env sh $env $file "$@"
    else
      # run command
      env sh $env $run $command "$@"
    fi
  } || env sh $env $help
}
