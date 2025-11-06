# Installation

Make a ~/.config dir if it doesn't already exist
```bash
mkdir -p ~/.config
```

Link everything you want to link
```bash
ln -sF $HOME/.dotfiles/zshrc         ~/.zshrc
ln -sF $HOME/.dotfiles/vimrc         ~/.vimrc
ln -sF $HOME/.dotfiles/ideavimrc     ~/.ideavimrc
ln -sF $HOME/.dotfiles/config/kitty  ~/.config/kitty
ln -sF $HOME/.dotfiles/config/bat    ~/.config/bat
ln -sF $HOME/.dotfiles/gitconfig     ~/.gitconfig
ln -sF $HOME/.dotfiles/xvimrc        ~/.xvimrc
ln -sF $HOME/.dotfiles/inputrc       ~/.inputrc
ln -sF $HOME/.dotfiles/psqlrc        ~/.psqlrc
```
