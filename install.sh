#!/bin/bash -ex

DIR=~/.dotfiles
_ZSHRC_LOCATION=${ZSHRC_LOCATION:-~/.zshrc}

# Make a ~/.config dir if it doesn't already exist
mkdir -p ~/.config

# install shit
echo "linking..."
ln -sF $DIR/zshrc         "${_ZSHRC_LOCATION}"
ln -sF $DIR/vimrc         ~/.vimrc
ln -sF $DIR/ideavimrc     ~/.ideavimrc
ln -sF $DIR/config/kitty  ~/.config/kitty
ln -sF $DIR/config/bat    ~/.config/bat
ln -sF $DIR/tmux.conf     ~/.tmux.conf
ln -sF $DIR/gitconfig     ~/.gitconfig
ln -sF $DIR/xvimrc        ~/.xvimrc
ln -sF $DIR/inputrc       ~/.inputrc
ln -sF $DIR/psqlrc        ~/.psqlrc

# install Vundle and plugins
echo "cloning vundle..."
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "installing vundle plugins..."
vim +PluginInstall +qall
