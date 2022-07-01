#!/bin/sh

# install packages
sudo apt-get install -y zsh curl

# install neovim
if ! echo "dce77cae95c2c115e43159169e2d2faaf93bce6862d5adad7262f3aa3cf60df8 /tmp/nvim-linux64.deb" | sha256sum -c; then
  wget -O /tmp/nvim-linux64.deb https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.deb
fi
sudo apt install /tmp/nvim-linux64.deb

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

# install go
sudo rm -rf /usr/local/go
if ! echo "956f8507b302ab0bb747613695cdae10af99bbd39a90cae522b7c0302cc27245 /tmp/go1.18.3.linux-amd64.tar.gz" | sha256sum -c; then
  wget -O /tmp/go1.18.3.linux-amd64.tar.gz https://go.dev/dl/go1.18.3.linux-amd64.tar.gz
fi
sudo tar -C /usr/local -xzf /tmp/go1.18.3.linux-amd64.tar.gz
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

