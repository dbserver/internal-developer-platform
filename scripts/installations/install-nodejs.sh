#!/bin/sh

echo "###############################################################"
echo "#########           INSTALL NODE JS/NPM/YARN          #########"
echo "###############################################################"

set -e
# Install node and npm via nvm - https://github.com/creationix/nvm

# Run this script like - bash script-name.sh

# Define versions
INSTALL_NODE_VER=18.7.0
INSTALL_NVM_VER=0.39.3
INSTALL_YARN_VER=1.22.19

 if ! [ -x "$(command nvm -v)" ]; then
	echo "Nvm already installed!!"	
else
	# You can pass argument to this script --version 8
	if [ "$1" = '--version' ]; then
		echo "==> Using specified node version - $2"
		INSTALL_NODE_VER=$2
	fi

	echo "==> Ensuring .bashrc exists and is writable"
	touch ~/.bashrc

	echo "==> Installing node version manager (NVM). Version $INSTALL_NVM_VER"

	# Removed if already installed
	rm -rf ~/.nvm

	# Unset exported variable
	export NVM_DIR=

	# Install nvm 
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v$INSTALL_NVM_VER/install.sh | bash

	# Make nvm command available to terminal
	source ~/.nvm/nvm.sh

	echo "==> Installing node js version $INSTALL_NODE_VER"
	nvm install $INSTALL_NODE_VER

	echo "==> Make this version system default"
	nvm alias default $INSTALL_NODE_VER
	nvm use default
fi


 if ! [ -x "$(command yarn -v)" ]; then
	echo "Yarn already installed!!"
	exit
else

	#echo -e "==> Update npm to latest version, if this stuck then terminate (CTRL+C) the execution"
	#npm install -g npm

	echo "==> Installing Yarn package manager"
	rm -rf ~/.yarn
	curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version $INSTALL_YARN_VER

	echo "==> Adding Yarn to environment path"

	# Yarn configurations
	export PATH="$HOME/.yarn/bin:$PATH"
	yarn config set prefix ~/.yarn -g

	echo "==> Checking for versions"
	nvm --version
	node --version
	npm --version
	yarn --version

	echo "==> Print binary paths"
	which npm
	which node
	which yarn

	echo "==> List installed node versions"
	nvm ls

	nvm cache clear
	echo "==> Now you're all setup and ready for development. If changes are yet totake effect, I suggest you restart your computer"

fi

# Tested on Ubuntu, MacOS