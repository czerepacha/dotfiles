# oh-my-zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# theme
ZSH_THEME="ys"

# plugins
plugins=(git golang rust terraform)

# source oh-my-zsh stuff
source $ZSH/oh-my-zsh.sh

# editor
export EDITOR='nvim'

# golang path
export PATH=$PATH:/usr/local/go/bin

# local binaries path
export PATH=$PATH:$HOME/.local/bin

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load secrets
source $HOME/.secrets.sh

