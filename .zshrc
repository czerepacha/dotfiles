export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env

export PATH="$PATH:$HOME/.dotnet"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"

export EDITOR="vim"
alias vim=nvim
alias python=python3
alias pip=pip3

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

