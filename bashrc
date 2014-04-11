export PATH=$PATH:/usr/local/bin

# for node
export PATH=/usr/local/share/npm:$PATH

# for python
export PATH=/usr/local/lib:$PATH
#source /usr/local/bin/virtualenvwrapper.sh

# for heroku
export PATH="/usr/local/heroku/bin:$PATH"

# for rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# sync bash history with multiple sessions
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ALWAYS VIM
export EDITOR=vim
set -o vi

# source my xmodmap
xmodmap ~/.xmodmap 2>/dev/null

# set prompt
export PS1="\$(short_pwd)\[\e[36m\]\`parse_git_branch\`\[\e[m\] "

# shortcut aliases
alias reset="source $HOME/.bashrc && clear"
alias la="ls -al"
alias ll="ls -l"
alias ..="cd .."
alias :q="exit"
alias vi="vim"
alias ls="ls -G"

# for tmux
alias tls="tmux list-sessions"
alias tas="tmux attach-session -t"

# asthetics aliases
alias jshint="clear; jshint"
alias node="clear; node"
alias coffee="clear; coffee"
alias ack="clear; ack"

# 256 colors in tmux
alias tmux="tmux -2"


# git aliases
alias gc='git commit -am'
alias gs='git status'

# Pushes current branch only
alias gps='git push origin `_get_git_branch`'

# Pulls current branch only
alias gpl='git pull origin `_get_git_branch`'

# vagrant short cuts
vup() {
	cd ~/vagrant/$@/ && vagrant up
}

new_vm() {
	$HOME/chartbeat/external/vmutils/create_vagrant_vm.py -H $@.chartbeat.com -G $HOME/chartbeat/ -v3
	cd $HOME/vagrant/$@
	vagrant up
}

# git branches autocomplete script, require .git-completion.bash in ~
source ~/.dotfiles/scripts/git-completion.bash


#### Chartbeat specific settings ####
export PYTHONPATH=/usr/local/lib/python2.7/site-packages
export PYTHONPATH=/Users/devon/chartbeat:$PYTHONPATH

alias t="tree -I '*.pyc|__init__.py'"

# get the server list for a type
gsl() {
	$HOME/chartbeat/external/tools/get_server_list.py $@
}

# polysh into all servers of a type
psh() {
	HOSTS=`gsl $@`
	
	# remove the existing entries in ~/.ssh/known_hosts
	for server in $HOSTS
	do
		ssh-keygen -R $server
	done

	# rescan and add them to known_hosts
	ssh-keyscan $HOSTS >> $HOME/.ssh/known_hosts
	
	# ssh into them simulaneously
	polysh $HOSTS
}


#### dirty helper functions ####
function short_pwd() {
    cwd=$(pwd | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')
    echo -n $cwd
}

function _get_git_branch() {
	echo `git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)//'`
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "(${BRANCH}${STAT})"
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
		echo "${bits}"
	else
		echo ""
	fi
}
