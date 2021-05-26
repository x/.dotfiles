# Installation

1. ```cd ~ && git clone git@github.com:x/.dotfiles.git```
2. ```cd ~/.dotfiles && ./install.sh```
3. ```echo ". ~/.bashrc" > ~/.bash_profile```

# Installing fancy fonts for vim-airline

1. ```cd ~ && git clone git@github.com:powerline/fonts.git ~/.powerline_fonts```
2. ```cd ~/.powerline_fonts && ./install.sh```

# Setting up fonts
```brew tap homebrew/cask-fonts && brew install font-fira-code```

# Using macvim instead of system vim (needs full XCode install)
```brew install macvim --override-system-vim```

# Other stuff to brew-install
```
brew install git bash bash-completion tmux reattach-to-user-namespace
```
