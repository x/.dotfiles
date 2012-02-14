export PATH="$HOME/local/bin:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH"
export LD_LIBRARY_PATH="$HOME/local/lib:/usr/local/lib"
export C_INCLUDE_PATH="$HOME/local/include:/usr/local/include"xport PATH=$PATH:/filer/tmp2/contrib/bin:/usr/sbin:/sbin
alias reset="source $HOME/.bashrc && clear"

alias la="ls -al"
alias ll="ls -l"
alias ..="cd .."
alias vi="vim"
alias ls="ls --color"

alias cd="clear; cd $@"

alias :q="exit"


alias chrome="rm ~/.config/chromium/SingletonLock; chrome"

export PS1="[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\W\[\033[00m\]]\$ "
export editor=vim

alias jshint="clear; jshint"
