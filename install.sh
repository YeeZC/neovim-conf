#!/bin/bash
dir=$(cd `dirname $0`; pwd)
echo "原地址为$dir"
if [ -e "$HOME/.config/nvim" ]
then
    rm -rf $HOME/.config/nvim/init.vim
    rm -rf $HOME/.config/nvim/init.lua
    rm -rf $HOME/.config/nvim/coc-settings.json
    rm -rf $HOME/.config/nvim/lua
fi
mkdir -p ~/.config/nvim
ln -s $dir/init.lua $HOME/.config/nvim/init.lua
ln -s $dir/coc-settings.json $HOME/.config/nvim/coc-settings.json
ln -s $dir/lua $HOME/.config/nvim
mkdir -p $HOME/.vim/after/autoload/coc
if [ -e "$HOME/.vim/after/autoload/coc/ui.vim" ]
then
    rm -rf $HOME/.vim/after/autoload/coc/ui.vim
fi
ln -s $dir/.vim/after/autoload/coc/ui.vim $HOME/.vim/after/autoload/coc/ui.vim

# 自动安装 vim plugins
  echo "开始安装 vim plugins..."
  bash -c "nvim +PackerSync +qall"
    echo "Successfully install vim plugins."