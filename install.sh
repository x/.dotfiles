#!/bin/bash

DIR=~/.dotfiles

# install shit
ln -s $DIR/bashrc    ~/.bashrc
ln -s $DIR/vimrc     ~/.vimrc
ln -s $DIR/tmux.conf ~/.tmux.conf
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/xvimrc    ~/.xvimrc

# source bashrc
source ~/.bashrc
