export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env

export PATH="$PATH:$HOME/.dotnet"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"

export EDITOR="vim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

