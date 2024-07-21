#!/bin/bash

# SUPPORTED DISTROS:
# Fedora
# Ubuntu
# Debian
# Arch Linux

# DEPENDENCIES VERSION 
NODE_VERSION=22
DOTNET_VERSION=8.0

GRANTED=false

echo "======================| KEBABVIM |==========================="

# Get user permissions!
read -p "Sudo permissions are required for this bash script. Allow sudo permissions? (Y/N): " Perms
echo "WARNING: DEFAULT IS (NO)"
if [[ ! $Perms =~ ^[Yy][Ee]?[Ss]?$ ]]; then 
	echo "Permission's denied unable to go forward! exit 0"
	exit 0
fi

echo "Permission's granted installing dependencies!"

# INSTALL GIT 
if ! command -v git &> /dev/null; then 
	
	if [ -f /etc/redhat-release ]; then 

		sudo dnf install git -y

	elif [ -f /etc/lsb-release ]; then 

		sudo apt-get install git -y

	elif [ -f /etc/debian_version ]; then

		sudo apt-get install git -y 

	elif [ -f /etc/arch-release ]; then

		sudo pacman -Syu git --noconfirm

	else 
		echo "UNSUPPORTED DISTRO! UNABLE TO INSTALL CURL. PLEASE INSTALL CURL!"
		exit 1
	fi

	if ! command -v git &> /dev/null; then 
		echo "Failed to install git!"
		exit 1
	fi
fi 

# INSTALL CURL 
if ! command -v curl &> /dev/null; then 
	
	if [ -f /etc/redhat-release ]; then 

		sudo dnf install curl -y

	elif [ -f /etc/lsb-release ]; then 

		sudo apt-get install curl -y

	elif [ -f /etc/debian_version ]; then

		sudo apt-get install curl -y 

	elif [ -f /etc/arch-release ]; then

		sudo pacman -Syu curl --noconfirm

	else 
		echo "UNSUPPORTED DISTRO! UNABLE TO INSTALL CURL. PLEASE INSTALL CURL!"
		exit 1
	fi

	if ! command -v curl &> /dev/null; then
		echo "Failed to install curl!"
		exit 1
	fi

fi 

# INSTALL NODE JS & NPM !!
if ! command -v node &> /dev/null; then 
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

	source ~/.bashrc

	nvm install $NODE_VERSION
fi

# INSTALL PRETTIER 
sudo npm install -g prettier

# INSTALL STYLUA 
sudo npm i -g @johnnymorganz/stylua-bin

# INSTALL WGET
if ! command -v wget &> /dev/null; then 

	if [ -f /etc/redhat-release ]; then 

		sudo dnf install wget -y

	elif [ -f /etc/lsb-release ]; then 

		sudo apt-get install wget -y

	elif [ -f /etc/debian_version ]; then

		sudo apt-get install wget -y 

	elif [ -f /etc/arch-release ]; then

		sudo pacman -Syu wget --noconfirm

	else 
		echo "UNSUPPORTED DISTRO! UNABLE TO INSTALL WGET. PLEASE INSTALL WGET!"
		exit 1
	fi

	if ! command -v wget &> /dev/null; then 
		echo "Failed to install wget!"
		exit 1
	fi
fi

# Install dotnet!

if ! command -v dotnet &> /dev/null; then 

	wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh 

	if [ -f ./dotnet-install.sh ]; then

		chmod +x ./dotnet-install.sh 

		./dotnet-install.sh --channel $DOTNET_VERSION

		./dotnet-install.sh --channel $DOTNET_VERSION --runtime aspnetcore

		# CLEAN UP 
		test -f ./dotnet-install.sh && rm ./dotnet-install.sh 

	fi

fi

echo "ALL DEPENDENCIES SHOULD BE INSTALLED!"
exit 0



