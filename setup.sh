#!/bin/sh

# install packages
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y zsh neovim curl

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain stable

# install go
sudo rm -rf /usr/local/go
if ! echo "956f8507b302ab0bb747613695cdae10af99bbd39a90cae522b7c0302cc27245 /tmp/go1.18.3.linux-amd64.tar.gz" | sha256sum -c; then
  wget -O /tmp/go1.18.3.linux-amd64.tar.gz https://go.dev/dl/go1.18.3.linux-amd64.tar.gz
fi
sudo tar -C /usr/local -xzf /tmp/go1.18.3.linux-amd64.tar.gz

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

