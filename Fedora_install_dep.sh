#!/bin/bash

# WARNING THIS IS ONLY FOR FEDORA!!!

echo "INSTALLING DEPENDENCIES! SUDO PERMISSIONS REQUIRED!"

# Install dotnet 

sudo dnf install dotnet-sdk-8.0 aspnetcore-runtime-8.0 dotnet-runtime-8.0

# Install npm 

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

source ~/.bashrc

nvm install 22

# INSTALL PRETTIER

sudo npm install -g prettier

# INSTALL CLANG FORMAT 
sudo dnf install clang-tools-extra

# INSTALL STYLUA 
sudo npm i -g @johnnymorganz/stylua-bin
