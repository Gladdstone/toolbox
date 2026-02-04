#!/bin/sh
# Linux machine setup
set -e
arch=$(echo uname -m)

if command -v apt >/dev/null 2>&1; then
    PKG_MGR="apt"
elif command -v dnf >/dev/null 2>&1; then
    PKG_MGR="dnf"
else
    echo "Error: Neither apt nor dnf found."
    exit 1
fi

. /etc/os-release

case "$ID" in
    debian|ubuntu|linuxmint)
        echo "Debian-based system"
        $PKG_MGR install -y build-essential \
            curl \
            git \
            sl \
            runc
        ;;
    fedora)
        echo "Fedora-based system"
        $PKG_MGR install libcurl-devel \
            git-all
        source ./fedora/setup.sh
        ;;
    *)
        echo "Unknown or unsupported distro: $ID"
        exit 1
        ;;
esac

echo "Using $PKG_MGR"

$PKG_MGR update && $PKG_MGR upgrade -y

$PKG_MGR install -y ripgrep \
    mutt \
    vim

git config --global user.email "joe@example.com"
git config --global user.name "Joseph Farrell"
git config --global fetch.prune true

# install node (coc-vim dependency)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
source ~/.bashrc
nvm install node
npm install sass

curl https://sh.rustup.rs -sSf | bash -s -- -y

# Install Docker
installDocker() {
    $PKG_MGR update
    $PKG_MGR install ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
    $PKG_MGR update
    $PKG_MGR install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

read -rp "Install Docker? (y/n): " install-docker
[[ "$answer" =~ ^[Yy]([Ee][Ss])?$ ]] && installDocker

# Install k9s
if [[ "$arch" -eq "arm64" ]]; then
    wget https://github.com/derailed/k9s/releases/download/v0.50.9/k9s_Linux_arm64.tar.gz -O k9s_Linux.tar.gz
else
    wget https://github.com/derailed/k9s/releases/download/v0.50.9/k9s_Linux_amd64.tar.gz -O k9s_Linux.tar.gz
fi

tar -xvf k9s_Linux.tar.gz
mv ./k9s /usr/local/bin
rm k9s_Linux.tar.gz

mkdir ~/code
cp ./vim/.vimrc ~/.vimrc

# setting docker buildkit to 0 disables docker buildkit and causes docker to output docker v2 schema images rather than OCI
# this may be necessary when pushing to certain repositories, as mixing the two can cause problems
echo "export DOCKER_BUILDKIT=0" >> ~/.bashrc
echo "NEXT_TELEMETRY_DISABLED=1" >> ~/.bashrc
echo "STORYBOOK_DISABLE_TELEMETRY=1" >> ~/.bashrc
echo "alias reload=\"source ~/.bashrc\"" >> ~/.bashrc
echo "alias bashconfig=\"vim ~/.bashrc\"" >> ~/.bashrc
echo "alias vimconfig=\"vim ~/.vimrc\"" >> ~/.bashrc
echo "alias ip=\"curl ifconfig.me\"" >> ~/.bashrc

