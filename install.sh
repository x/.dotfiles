#!/bin/bash

DIR=~/.dotfiles

# install shit
echo "linking..."
ln -sF $DIR/bashrc    ~/.bashrc
ln -sF $DIR/vimrc     ~/.vimrc
ln -sF $DIR/tmux.conf ~/.tmux.conf
ln -sF $DIR/gitconfig ~/.gitconfig
ln -sF $DIR/xvimrc    ~/.xvimrc
ln -sF $DIR/inputrc   ~/.inputrc
ln -sF $DIR/hyper.js  ~/.hyper.js

# source bashrc
echo "sourcing bashrc..."
source ~/.bashrc

# install Vundle and plugins
echo "cloning vundle..."
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "installing vundle plugins..."
vim +PluginInstall +qall
