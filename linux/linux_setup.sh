#!/bin/sh
# Linux machine setup

apt-get update && apt-get upgrade -y

apt-get install build-essential \
    curl \
    git \
    runc \
    vim

# install node (coc-vim dependency)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm install node

curl https://sh.rustup.rs -sSf | bash -s -- -y

# Install Docker
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

mkdir ~/code
cp ./vim/.vimrc ~/.vimrc 

echo "NEXT_TELEMETRY_DISABLED=1" >> ~/.bashrc
echo "STORYBOOK_DISABLE_TELEMETRY=1" >> ~/.bashrc
echo "alias reload=\"source ~/.bashrc\"" >> ~/.bashrc
echo "alias bashconfig=\"vim ~/.bashrc\"" >> ~/.bashrc
echo "alias vimconfig=\"vim ~/.vimrc\"" >> ~/.bashrc
echo "alias ip=\"curl ifconfig.me\"" >> ~/.bashrc

