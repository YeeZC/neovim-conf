#!/bin/bash
dir=$(cd `dirname $0`; pwd)
mkdir -p $HOME/.config/nvim
ln -s $dir/init.vim $HOME/.config/nvim/init.vim
ln -s $dir/coc-settings.json $HOME/.config/nvim/coc-settings.json
mkdir -p $HOME/.vim/after/autoload/coc
ln -s $dir/.vim/after/autoload/coc/ui.vim $HOME/.vim/after/autoload/coc/ui.vim
mkdir -p $HOME/lua/plugin/
ln -s $dir/lua/plugin/nvim-tree.lua $HOME/lua/plugin/nvim-tree.lua

