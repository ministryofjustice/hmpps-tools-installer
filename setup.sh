#!/bin/bash

### Function Definitions
# Get CPU architecture
get_architecture(){
    echo "$(uname -p)"
}

# Install homebrew if not already installed
install_homebrew(){
    if test ! $(which brew); then
      echo "Installing homebrew"
      if [[ "$ARCH" == "$ARCH_I386" ]]; then
        echo "This will install to '/usr/local'"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      elif [[ "$ARCH" == "$ARCH_ARM" ]]; then
        echo "This will install to a different location for '/opt/homebrew'"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      else
        echo "Unknown architecture: $ARCH"
        exit 1;
      fi
    fi
}

do_casks_install(){
    local casks=("$@")
    for i in "${casks[@]}"; do
        echo "Uninstalling cask $i....."
        brew install --cask --force $i
    done
}

do_packages_install(){
    local packages=("$@")
    for i in "${packages[@]}"; do
        echo "Installing package $i...."
        brew install $i
    done
}

### Variables
# Architecture
ARCH=$(get_architecture)
ARCH_I386="i386"
ARCH_ARM="arm"

RECOMMENDED_PACKAGES=(
	git
	jq
	helm
	kubernetes-cli
	docker-compose
)

RECOMMENDED_CASKS=(
  docker
  intellij-idea
  slack
  postman
)

OPTIONAL_PACKAGES=(
  aws-elasticbeanstalk
  make
  awscli
  terraform
)

OPTIONAL_CASKS=(
)

#### Main
clear
cat << "EOF"
  __  __  ___     _
 |  \/  |/ _ \ _ | |    Welcome to Justice Digital!
 | |\/| | |_| | || |    ###########################
 |_|  |_|\___/ \__/     Developer Tools Script V0.1

EOF
if [[ "$ARCH" == "$ARCH_I386" ]]; then
  echo "Detected CPU architecture: Intel (i386)"
elif [[ "$ARCH" == "$ARCH_ARM" ]]; then
  echo "Detected CPU architecture: Apple Silicon (ARM)"
else
  echo "Unknown CPU architecture: $ARCH"
fi
echo "Please enter your choice: "
options=("Install recommended tools" "Install optional tools" "Install all tools" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Install recommended tools")
            echo "you chose to install tools for $opt - $REPLY"
            install_homebrew
            do_packages_install "${RECOMMENDED_PACKAGES[@]}"
            do_casks_install "${RECOMMENDED_CASKS[@]}"
            break
            ;;
        "Install optional tools")
            echo "you chose to install tools for $opt - $REPLY"
            install_homebrew
            do_packages_install "${OPTIONAL_PACKAGES[@]}"
            do_casks_install "${OPTIONAL_CASKS[@]}"
            break
            ;;
        "Install all tools")
            echo "you chose choice to install $opt - $REPLY"
            install_homebrew
            do_packages_install "${RECOMMENDED_PACKAGES[@]}"
            do_casks_install "${RECOMMENDED_CASKS[@]}"
            do_packages_install "${OPTIONAL_PACKAGES[@]}"
            do_casks_install "${OPTIONAL_CASKS[@]}"
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
