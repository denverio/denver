#!/usr/bin/env sh

{ # this ensures the entire script is downloaded # 

denver_install_settings() { 
  denver_install_section "Configuring..." 

  set -e # exit on error

  export DENVER_HOME=${DENVER_HOME:-"$HOME/.denver"}
  export DENVER_BRANCH=${DENVER_BRANCH:-'master'}

  if [ -d "$DENVER_HOME" ]
  then
    echo
    echo "You already have $DENVER_HOME installed."
    echo "You'll need to remove $DENVER_HOME if you want to re-install."
    echo
    exit 1
  fi

  echo "Configured:"
  echo "  DENVER_HOME=$DENVER_HOME"
  echo "  DENVER_BRANCH=$DENVER_BRANCH"
  echo
}

denver_install_dependencies() {
  denver_install_section "Installing dependencies..."

  sudo apt update

  sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    wget \
    git
}

denver_install_docker() {
  denver_install_section "Installing docker..."

  command -v docker >/dev/null && {
    echo "Docker is already installed. Ignoring..."
    echo
    return
  }

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo apt-key fingerprint 0EBFCD88

  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

  sudo apt update

  sudo apt install -y docker-ce
}

denver_install_dnsmasq() {
  denver_install_section "Installing dnsmasq..."

  command -v dnsmasq >/dev/null && {
    echo "DNS Masq is already installed. Ignoring..."
    echo
    return
  }

  sudo apt install -y dnsmasq

  echo "\naddress=/.localhost/127.0.0.1" | sudo tee -a /etc/dnsmasq.conf
  echo "address=/.devel/127.0.0.1" | sudo tee -a /etc/dnsmasq.conf
}

denver_install_env() {
  #denver_install_section "Installing .env..."

  wget -qO- \
    https://raw.githubusercontent.com/fiuzagr/env/v2/install.sh | \
    env \
      ENV_HOME="${DENVER_HOME}/.config" \
      ENV_BRANCH=v2 \
      sh
}

denver_install_denver() {
  denver_install_section "Installing denver..."

  # prevent insecure permissions
  umask g-w,o-w

  # cloning
  env git clone \
    --quiet \
    --depth=1 \
    --single-branch \
    -b "${DENVER_BRANCH}" \
    https://github.com/fiuzagr/denver.git "${DENVER_HOME}" >/dev/null && \
      cp ${DENVER_HOME}/.env.example ${DENVER_HOME}/.env || \
      {
        echo "Error: git clone 'fiuzagr/denver' is failed."
        echo
        exit 1
      }

  # define rc file
  local userShell=$(getent passwd $LOGNAME | cut -d: -f7)
  local rcFile="${HOME}/.profile"
  rcFile="$(test "${userShell#*zsh}" != "${userShell}" && echo "${HOME}/.zshrc" || echo $rcFile)" 
  rcFile="$(test "${userShell#*bash}" != "${userShell}" && echo "${HOME}/.bashrc" || echo $rcFile)" 

  # configure rc file
  if [ -f "${rcFile}" ]
  then
    grep -q "DENVER_HOME" "${rcFile}" && \
      echo "Denver is already configured in ${rcFile}." || \
      {
        echo "Configuring ${rcFile} file..."

        echo "\n# Denver" | tee -a "${rcFile}"
        echo "export DENVER_HOME=\"${DENVER_HOME}\"" | tee -a "${rcFile}"
        echo '[ -s "$DENVER_HOME/denver.sh" ] && \. $DENVER_HOME/denver.sh' | tee -a "${rcFile}"
      }
  fi

  echo "Installed at ${DENVER_HOME}."
  echo
}

denverInstallSectionStep=0
denver_install_section() {
  denverInstallSectionStep=$(expr "$denverInstallSectionStep" + "1")
  echo
  echo "${denverInstallSectionStep}. ${@}"
  echo
}

denver_install() {
  echo
  echo ' ---------------------- '
  echo '| Installing DENVER... |'
  echo ' ---------------------- '

  denver_install_settings

  denver_install_dependencies

  denver_install_docker

  denver_install_dnsmasq

  denver_install_denver

  echo ' ---------------------- '
  echo '| DENVER is installed! |'
  echo ' ---------------------- '
  echo

  # install env after denver
  denver_install_env

  echo
  echo 'Successful.'
  echo
}
denver_install

} # this ensures the entire script is downloaded #
