# add RVM to PATH for scripting
PATH=$HOME/local/bin:/usr/local/bin:/usr/local/share/npm/bin:$PATH:$HOME/.rvm/bin:/filer/tmp2/contrib/bin
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# virtualenv
#export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

# source nvm to load prefs and shit
#. ~/nvm/nvm.sh 2> /dev/null

export EDITOR=vim

# source my xmodmap
xmodmap ~/.xmodmap 2>/dev/null

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[37m\]\u\[\e[m\]@\[\e[33m\]\h\[\e[m\]:\W\[\e[36m\]\`parse_git_branch\`\[\e[m\] "

# shortcut aliases
alias reset="source $HOME/.bashrc && clear"
alias la="ls -al"
alias ll="ls -l"
alias ..="cd .."
alias :q="exit"
alias vi="vim"
alias pdf="evince"
alias rmswp="rm .*.swp"

# asthetics aliases
alias jshint="clear; jshint"
alias node="clear; node"
alias coffee="clear; coffee"
alias ack="clear; ack-grep --before-context=2 --after-context=2 --color-filename=blue"

# 256 colors in tmux
alias tmux="tmux -2"

# mooooor color
TERM=xterm-color

# start and stop postgres
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# start tmux on startup
#if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
#    tmux attach || tmux new; exit
#fi

# git branches autocomplete script, require .git-completion.bash in ~
source ~/.dotfiles/scripts/git-completion.bash

# git aliases
get_git_branch() {
	  echo `git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)//'`
  }
alias gc='git commit -am'
alias gs='git status'

# Pushes current branch only
alias gps='git push origin `get_git_branch`'

# Pulls current branch only
alias gpl='git pull origin `get_git_branch`'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
