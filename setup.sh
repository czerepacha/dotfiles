#!/bin/sh

set -e -v

# versions
NVIM_RELEASE="v0.9.4"
GO_VERSION="1.21.3"

# install packages
sudo apt-get -qq install -y zsh curl git make python3 python3-pip software-properties-common fd-find unzip

# install kubectl
sudo curl -sL "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /tmp/kubectl
sudo chmod 755 /tmp/kubectl && sudo mv /tmp/kubectl /usr/local/bin/

# install neovim
sudo wget -qO /tmp/nvim-linux64.tar.gz "https://github.com/neovim/neovim/releases/download/${NVIM_RELEASE}/nvim-linux64.tar.gz"
tar -xvf /tmp/nvim-linux64.tar.gz -C "${HOME}/.local"

# install rust
wget -qO /tmp/rustup-init "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"
chmod +x /tmp/rustup-init && /tmp/rustup-init -y --quiet --default-toolchain stable >/dev/null 2>&1

# install go
GORELEASE="go${GO_VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo wget -qO "/tmp/${GORELEASE}" "https://go.dev/dl/${GORELEASE}"
sudo tar -C /usr/local -xzf "/tmp/${GORELEASE}"
sudo chmod -R a+rx /usr/local/go

# install nodejs
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y

# install oh-my-zsh
rm -rf ~/.oh-my-zsh
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null 2>&1

# install astronvim
rm -rf ~/.config/nvim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

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

# set up dotfiles
touch ~/.secrets.sh
mkdir -p ~/.config/nvim
mkdir -p ~/go/bin
ln -sf "${PWD}/.zshrc" ~/.zshrc
ln -sf "${PWD}/nvim-config" ~/.config/nvim

