#!/bin/sh

touch ~/.secrets.sh
ln -sf ~/.zshrc .zshrc
mkdir -p ~/.config/nvim
ln -sf ~/.config/nvim/init.lua .config/nvim/init.lua
