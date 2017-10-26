# for homebrew python (brew install python) to override system python
export PATH=/usr/local/opt/python/libexec/bin:$PATH

# for heroku
export PATH="/usr/local/heroku/bin:$PATH"

# for node
export PATH=/usr/local/share/npm:$PATH

# for rvm
export PATH=$PATH:$HOME/.rvm/bin

# for gcloud
. /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
. /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc

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

# set prompt to be a short-hand path with git_ps1
export PS1="\$(short_pwd)\$(__git_ps1 | tr -d ' ')$ "

# 256 colors in tmux
alias tmux="tmux -2"

# shortcuts for vagrant
alias v="vagrant"

## Oden Crap ##
export PATH=/Users/devon/scripts:$PATH

function qa() {
	gcloud config configurations activate qa && gcloud container clusters get-credentials services-1 --zone us-east1-d --project oden-qa && export GCE_PROJECT=oden-qa && export DRONE_SERVER=https://drone.oden-qa.io
}

function prod() {
	gcloud config configurations activate prod && gcloud container clusters get-credentials services-1 --zone us-east1-d --project oden-production && export GCE_PROJECT=oden-production
}
