#!/bin/bash

set -e -v

# versions
NVIM_RELEASE="v0.9.5"
GO_VERSION="1.22.2"

# home prep
touch ~/.secrets.sh

mkdir -p ~/.local
mkdir -p ~/.config
mkdir -p ~/go/bin

# install packages
sudo apt-get -qq install -y zsh curl git make python3 python3-pip python3-venv software-properties-common fd-find unzip

# install dotnet
sudo add-apt-repository -s -y ppa:dotnet/backports >/dev/null 2>&1
sudo apt-get -qq install -y dotnet-sdk-8.0 dotnet-sdk-7.0 dotnet-sdk-6.0

# install kubectl
RELEASE_SHA512=$(curl -sL https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha512)
LOCAL_SHA512=$(sha512sum $(which kubectl) | cut -d ' ' -f1)
if [[ ${LOCAL_SHA512} != ${RELEASE_SHA512} ]]; then
	sudo curl -sL "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl
	sudo chmod 755 /tmp/kubectl && sudo mv /tmp/kubectl /usr/local/bin/
fi

# install neovim
sudo wget -qO /tmp/nvim-linux64.tar.gz "https://github.com/neovim/neovim/releases/download/${NVIM_RELEASE}/nvim-linux64.tar.gz"
tar -xf /tmp/nvim-linux64.tar.gz -C "${HOME}/.local"

# install rust
wget -qO /tmp/rustup-init "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"
chmod +x /tmp/rustup-init && /tmp/rustup-init -y --quiet --default-toolchain stable >/dev/null 2>&1

# install go
# checksums: https://go.dev/dl/
GORELEASE="go${GO_VERSION}.linux-amd64.tar.gz"
GORELEASE_SHA256SUM="374ea82b289ec738e968267cac59c7d5ff180f9492250254784b2044e90df5a9"
GOLOCAL_SHA256SUM=$(sha256sum /tmp/${GORELEASE} | cut -d ' ' -f1)

if [[ ${GORELEASE_SHA256SUM} != ${GOLOCAL_SHA256SUM} ]]; then
	sudo wget -qO "/tmp/${GORELEASE}" "https://go.dev/dl/${GORELEASE}"
fi

sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "/tmp/${GORELEASE}"
sudo chmod -R a+rx /usr/local/go

# install nodejs
sudo apt-get -qq install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get -qq update
sudo apt-get -qq install nodejs -y

# install oh-my-zsh
rm -rf ~/.oh-my-zsh
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null 2>&1

# install fzf
rm -rf ~/.fzf
git clone -q --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all >/dev/null 2>&1

# install ripgrep
(cd /tmp && curl -sLO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb)
sudo dpkg -i /tmp/ripgrep_13.0.0_amd64.deb >/dev/null 2>&1

# install bat
(cd /tmp && curl -sLO https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb)
sudo dpkg -i /tmp/bat_0.22.1_amd64.deb >/dev/null 2>&1

# prepare links
rm ~/.zshrc && ln -sf "${PWD}/.zshrc" ~/.zshrc
rm ~/.config/nvim && ln -sf "${PWD}/nvim" ~/.config/nvim
