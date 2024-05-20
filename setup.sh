#!/bin/bash

set -e -v

# versions
declare -r NVIM_RELEASE="v0.10.0"
declare -r GO_VERSION="1.22.3"

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
kubectl_release_sha512sum=$(curl -sL "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha512")
kubectl_local_sha512sum=$(sha512sum /usr/local/bin/kubectl | cut -d ' ' -f1)
if [[ ${kubectl_release_sha512sum} != "${kubectl_local_sha512sum}" ]]; then
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
go_release="go${GO_VERSION}.linux-amd64.tar.gz"
go_release_sha256sum="374ea82b289ec738e968267cac59c7d5ff180f9492250254784b2044e90df5a9"
go_local_sha256sum=$(sha256sum /tmp/${go_release} | cut -d ' ' -f1)

if [[ ${go_release_sha256sum} != "${go_local_sha256sum}" ]]; then
	sudo wget -qO "/tmp/${go_release}" "https://go.dev/dl/${go_release}"
fi

sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "/tmp/${go_release}"
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
(cd /tmp && curl -sLO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb)
sudo dpkg -i /tmp/ripgrep_14.1.0-1_amd64.deb >/dev/null 2>&1

# install bat
(cd /tmp && curl -sLO https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb)
sudo dpkg -i /tmp/bat_0.24.0_amd64.deb >/dev/null 2>&1

# prepare links
rm -rf ~/.zshrc && ln -sf "${PWD}/.zshrc" ~/.zshrc
rm -rf ~/.config/nvim && ln -sf "${PWD}/nvim" ~/.config/nvim
