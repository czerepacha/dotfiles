export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(git golang)

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env

export GOPATH="$HOME/go"

export PATH="$PATH:$GOPATH"
export PATH="$PATH:$HOME/.dotnet"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.local/nvim-linux64/bin"

export EDITOR="nvim"
alias vim=nvim
alias python=python3
alias pip=pip3
alias cat=bat

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

