#!/bin/sh

# install packages
sudo apt-get install -y zsh curl git

# install neovim
sudo wget -O /tmp/nvim-linux64.deb https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
sudo apt install /tmp/nvim-linux64.deb

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

# install go
GORELEASE=go1.19.linux-amd64.tar.gz
sudo rm -rf /usr/local/go
sudo wget -O /tmp/$GORELEASE https://go.dev/dl/$GORELEASE
sudo tar -C /usr/local -xzf /tmp/$GORELEASE
sudo chmod -R a+rx /usr/local/go

# install oh-my-zsh
rm -rf ~/.oh-my-zsh
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install astrovim
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# set up dotfiles
touch ~/.secrets.sh
ln -sf $(pwd)/.zshrc ~/.zshrc
mkdir -p ~/go/bin

