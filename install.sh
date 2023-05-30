#!/bin/bash
dir=$(
	cd $(dirname $0)
	pwd
)
echo "原地址为$dir"
if [ -e "$HOME/.config/nvim" ]; then
	rm -rf $HOME/.config/nvim
fi
mkdir -p ~/.config/nvim
ln -s $dir/init.lua $HOME/.config/nvim/init.lua
ln -s $dir/lua $HOME/.config/nvim
mkdir -p $HOME/.vim/after/autoload/coc
if [ -e "$HOME/.vim/after/autoload/coc/ui.vim" ]; then
	rm -rf $HOME/.vim/after/autoload/coc/ui.vim
fi

# 自动安装 vim plugins
echo "开始安装 vim plugins..."
bash -c "nvim '+Lazy sync' +qa"
echo "Successfully install vim plugins."
