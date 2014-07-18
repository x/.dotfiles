# if there's a .secrets file with environment options, source it
if [ -f $HOME/.secrets ]; then
	source $HOME/.secrets
fi

export PATH=$PATH:/usr/local/bin

# for node
export PATH=/usr/local/share/npm:$PATH

# for python
export PATH=/usr/local/lib:$PATH

# for heroku
export PATH="/usr/local/heroku/bin:$PATH"

# for rvm
PATH=$PATH:$HOME/.rvm/bin

# sync bash history with multiple sessions
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ALWAYS VIM
export EDITOR=vim
set -o vi

# source my xmodmap
xmodmap ~/.xmodmap 2>/dev/null

# git bash autocomplete
source `brew --prefix`/etc/bash_completion

# set prompt
function short_pwd() {
	echo -n $(pwd | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')
}
# set prompt to be a short-hand path with git_ps1
export PS1="\$(short_pwd)\$(__git_ps1 | tr -d ' ')$ "

# 256 colors in tmux
alias tmux="tmux -2"

# shortcuts for tmux
alias tls="tmux list-sessions"
alias tas="tmux attach-session -t"

# Just for Chartbeat
# ------------------
export PYTHONPATH=/usr/local/lib/python2.7/site-packages
export PYTHONPATH=/Users/devon/chartbeat:$PYTHONPATH

# the worst things in the world to find in our repo
export FUCKING_GLOBAL_CONFS=/Users/devon/chartbeat/private/puppet/modules/chartbeat/templates/globalconf/
export NODES_LOCAL=$HOME/chartbeat/private/puppet/manifests/nodes_local.pp

# spin up a new VM
new_vm() {
	$HOME/chartbeat/external/vmutils/create_vagrant_vm.py -H $@.chartbeat.net -G $HOME/chartbeat/ -v3 --distro=precise
	cd $HOME/vagrant/$@
	vagrant up
}

# get the server list for a type
gsl() {
	$HOME/chartbeat/external/tools/get_server_list.py $@
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
