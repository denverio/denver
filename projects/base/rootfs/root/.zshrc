export DENVER_HOME=${DENVER_HOME:-"/denver"}
[ -s "$DENVER_HOME/denver.sh" ] && \. "$DENVER_HOME/denver.sh"

[ -s "$DENVER_CONFIG/zsh/.zshrc" ] && \. "$DENVER_CONFIG/zsh/.zshrc"
