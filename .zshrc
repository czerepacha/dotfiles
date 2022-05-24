export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

ZSH_THEME="ys"

plugins=(git)

export PATH="$PATH:$HOME/.dotnet"
export EDITOR="vim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

