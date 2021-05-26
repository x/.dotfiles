#!/bin/bash -ex

DIR=~/.dotfiles
_ZSHRC_LOCATION=${ZSHRC_LOCATION:-~/.zshrc}

# install shit
echo "linking..."
ln -sF $DIR/zshrc         $_ZSHRC_LOCATION
ln -sF $DIR/vimrc         ~/.vimrc
ln -sF $DIR/tmux.conf     ~/.tmux.conf
ln -sF $DIR/gitconfig     ~/.gitconfig
ln -sF $DIR/xvimrc        ~/.xvimrc
ln -sF $DIR/inputrc       ~/.inputrc
ln -sF $DIR/psqlrc        ~/.psqlrc

# source bashrc
echo "sourcing zshrc..."
source $_ZSHRC_LOCATION

# install Vundle and plugins
echo "cloning vundle..."
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "installing vundle plugins..."
vim +PluginInstall +qall
