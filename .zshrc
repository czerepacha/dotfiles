export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.dotnet"
export EDITOR="vim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

