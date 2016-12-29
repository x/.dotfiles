# for node
export PATH=/usr/local/share/npm:$PATH

# for python
export PATH=/usr/local/lib:$PATH

# for heroku
export PATH="/usr/local/heroku/bin:$PATH"

# for rvm
export PATH=$PATH:$HOME/.rvm/bin

# set up ssh-agent with my private key
if [ -z "$SSH_AUTH_SOCK" ] ; then
	eval `ssh-agent -s`
	ssh-add
fi

# sync bash history with multiple sessions
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# moar history
export HISTSIZE=5000
export HISTFILESIZE=5000

# vim life
export EDITOR=vim

# git bash autocomplete
if [ -f `brew --prefix`/etc/bash_completion ]; then
	source `brew --prefix`/etc/bash_completion
fi

# set prompt
function short_pwd() {
	echo -n $(pwd | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')
}
function repo() {
	if [ $(pwd | grep chartbeat) ]; then
		echo -n '(dev)'
	elif [ $(pwd | grep oncall) ]; then
		echo -n '(on-call)'
	fi
}
# set prompt to be a short-hand path with git_ps1
export PS1="\$(short_pwd)\$(__git_ps1 | tr -d ' ')$ "

# 256 colors in tmux
alias tmux="tmux -2"

# shortcuts for tmux
alias tls="tmux list-sessions"
alias tas="tmux attach-session -t"

# shortcuts for vagrant
alias v="vagrant"

# Just for Chartbeat
# ------------------

# get the server list for a type
gsl() {
	$HOME/chartbeat/bin/instance_tool get_server_list $@
}

# polysh into all servers of a type
psh() {
	local hosts=`gsl $1`
	local other_args=${2} ... ${10}
	local server
	
	# remove the existing entries in ~/.ssh/known_hosts
	for server in $hosts
	do
		ssh-keygen -R $server
	done

	# rescan and add them to known_hosts
	ssh-keyscan $hosts >> $HOME/.ssh/known_hosts
	
	# ssh into them simulaneously
	polysh $hosts 
}


#  ,__,
#  (oo)____
#  (__)    )\
#     ||--|| *
fortune -s | cowsay
