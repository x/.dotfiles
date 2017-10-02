# Installation

1. ```cd ~ && git clone git@github.com:x/.dotfiles.git```
2. ```cd ~/.dotfiles && ./install.sh```

# Installing fancy fonts for vim-airline

1. ```cd ~ && git clone git@github.com:powerline/fonts.git ~/.powerline_fonts```
2. ```cd ~/.powerline_fonts && ./install.sh```

# Setting up fonts
```brew tap caskroom/fonts && brew cask install font-fira-code```

# Using macvim instead of system vim (needs full XCode install)
```brew install macvim --override-system-vim```

# Other stuff to brew-install
```
brew intall \
	git \                        # better than system git
	bash \                       # better than system bash
	bash-completion \            # exposes __git_ps1
	tmux \                       # better than panes in iterm2
	reattach-to-user-namespace \ # needed for system clipboard copy in tmux
	```
