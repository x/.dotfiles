#!/bin/bash

DIR=~/.dotfiles

# install shit
echo "linking..."
ln -s $DIR/bashrc    ~/.bashrc
ln -s $DIR/vimrc     ~/.vimrc
ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/xvimrc    ~/.xvimrc
ln -s $DIR/hyper.js  ~/.hyper.js

# source bashrc
echo "sourcing bashrc..."
source ~/.bashrc

# install Vundle and plugins
echo "cloning vundle..."
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "installing vundle plugins..."
vim +PluginInstall +qall
