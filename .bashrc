# path exports
#export PATH="$HOME/usr/local/bin:/local/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#export LD_LIBRARY_PATH="$HOME/local/lib:/usr/local/lib"
#export C_INCLUDE_PATH="$HOME/local/include:/usr/local/include"xport PATH=$PATH:/filer/tmp2/contrib/bin:/usr/sbin:/sbin

PATH=/usr/local/bin:$PATH

# other exports
#export PS1="[\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\W\033[00m\]]\$ "
export editor=vim

# show working branch in status
PS1='\[\033[01;36m\]\W\033[00;34m\]$(__git_ps1 "|%s")\033[00m\] \$ '
export PROMPT_COMMAND='echo -ne "\033]0;${PWD/#$HOME/~}\007"'


# shortcut aliases
alias reset="source $HOME/.bashrc && clear"
alias la="ls -al"
alias ll="ls -l"
alias ..="cd .."
alias :q="exit"
alias vi="vim"
alias pdf="evince"

# asthetics aliases
alias ls="ls -G"
alias jshint="clear; jshint"
alias node="clear; node"
alias coffee="clear; coffee"
alias ack="clear; ack --before-context=2 --after-context=2 --color-filename=blue"


# custom commands
alias update="cp ~/dotfiles/.bashrc ~/dotfiles/.vimrc ~/dotfiles/.tmux.conf ~/.git-completion.bash ~/; source ~/.bashrc"
alias artem="ssh devon@ec2-107-20-71-36.compute-1.amazonaws.com"

# 256 colors in tmux
alias tmux="tmux -2"

# custom CD
# this breaks on new account, idk why
#mycd(){
#  unalias cd
#  clear
#
#  if [ $# -ne 1 ]
#  then
#    cd ~
#    echo -e "[\e[01;32m`whoami`@`hostname`:\e[01;34m~\e[00m]$ ls"
#  else
#    cd $1
#    echo -e "[\e[01;32m`whoami`@`hostname`:\e[01;34m${PWD##*/}\e[00m]$ ls"
#  fi
#
#  pwd
#  ls
#  alias cd=mycd
#}
#alias cd=mycd

# branch stuff
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
[[ -s "/Users/work/.rvm/scripts/rvm" ]] && . "/Users/work/.rvm/scripts/rvm"
eval "alias git=hub"

# start tmux on startup
if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach || tmux new; exit
fi

# git branches autocomplete script, require .git-completion.bash in ~
source ~/.git-completion.bash
