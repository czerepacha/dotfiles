#!/bin/sh

# versions
NVIM_RELEASE="v0.8.1"
GO_VERSION="1.19"
RUST_VERSION="stable"

# install packages
sudo apt-get install -y zsh curl git

# install kubectl
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo chmod 755 ./kubectl && sudo mv ./kubectl /usr/local/bin/

# install neovim
sudo wget -O /tmp/nvim-linux64.deb "https://github.com/neovim/neovim/releases/download/${NVIM_RELEASE}/nvim-linux64.deb"
sudo apt install /tmp/nvim-linux64.deb

# install rust
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain "${RUST_VERSION}"

# install go
GORELEASE="go${GO_VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo wget -O "/tmp/${GORELEASE}" "https://go.dev/dl/${GORELEASE}"
sudo tar -C /usr/local -xzf "/tmp/${GORELEASE}"
sudo chmod -R a+rx /usr/local/go

# install oh-my-zsh
rm -rf ~/.oh-my-zsh
CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install lunarvim
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
(cd /tmp && curl -LO https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
bash /tmp/install.sh -y

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install ripgrep
(cd /tmp && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb)
sudo dpkg -i /tmp/ripgrep_13.0.0_amd64.deb

# install bat
(cd /tmp && curl -LO https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb)
sudo dpkg -i /tmp/bat_0.22.1_amd64.deb

# set up dotfiles
touch ~/.secrets.sh
ln -sf "$(pwd)/.zshrc" ~/.zshrc
mkdir -p ~/go/bin

