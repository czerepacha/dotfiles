export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="ys"

plugins=(git golang)

source $ZSH/oh-my-zsh.sh
source $HOME/.cargo/env


export GOPATH="$HOME/go"

export PATH="$PATH:$GOPATH"
export PATH="$PATH:$HOME/.dotnet"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin"

export EDITOR="vim"
alias vim=lvim
alias python=python3
alias pip=pip3
alias cat=bat

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

