#!/bin/sh

# install packages
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y zsh neovim curl

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

# install go
sudo rm -rf /usr/local/go
wget https://go.dev/dl/go1.18.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.18.3.linux-amd64.tar.gz
rm go1.18.3.linux-amd64.tar.gz

# install oh-my-zsh
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install astrovim
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# set up dotfiles
touch ~/.secrets.sh
ln -sf .zshrc ~/.zshrc
mkdir -p ~/go/bin

