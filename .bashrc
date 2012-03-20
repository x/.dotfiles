# path exports
export PATH="$HOME/local/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export LD_LIBRARY_PATH="$HOME/local/lib:/usr/local/lib"
export C_INCLUDE_PATH="$HOME/local/include:/usr/local/include"xport PATH=$PATH:/filer/tmp2/contrib/bin:/usr/sbin:/sbin


# other exports
export PS1="[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\W\[\033[00m\]]\$ "
export editor=vim


# shortcut aliases
alias reset="source $HOME/.bashrc && clear"
alias la="ls -al"
alias ll="ls -l"
alias ..="cd .."
alias vi="vim"
alias :q="exit"


# asthetics aliases
alias ls="ls -G"
alias cd="clear; cd $@"
alias jshint="clear; jshint"
alias node="clear; node"
alias coffee="clear; coffee"


# custom commands
alias update="cp ~/dotfiles/.bashrc ~/dotfiles/.vimrc ~/dotfiles/.tmux.conf ~/ > /dev/null; source ~/.bashrc"

