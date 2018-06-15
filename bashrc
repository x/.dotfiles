# for heroku
export PATH="/usr/local/heroku/bin:$PATH"

# for node
export PATH=/usr/local/share/npm:$PATH

# for rvm
export PATH=$PATH:$HOME/.rvm/bin

# for go
export PATH=$PATH:$GOPATH/bin

# for vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# for gcloud
. /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
. /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc

export HISTSIZE=50000
export HISTFILESIZE=50000
export EDITOR=vim

# git bash autocomplete
if [ -f `brew --prefix`/etc/bash_completion ]; then
	source `brew --prefix`/etc/bash_completion
fi

# set prompt
function ps1() {
	SHORT_PWD="$(pwd | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')"
	GCP_PROJECT="$(cat ~/.config/gcloud/active_config | xargs -I{} cat ~/.config/gcloud/configurations/config_{} | grep project | cut -d ' ' -f 3)"
	GIT_BRANCH="$(__git_ps1 | tr -d ' ()')"

	if [ -z "$GIT_BRANCH" ]; then
		echo -n "${SHORT_PWD} ➜ ${GCP_PROJECT} ➜ "
	else
		echo -n "${SHORT_PWD} ➜ ${GCP_PROJECT} ➜ ${GIT_BRANCH} ➜ "
	fi
}
export PS1="\$(ps1)"

# 256 colors in tmux
alias tmux="tmux -2"

# shortcuts for common tools
alias v="vagrant"
alias k="kubectl"

# set up ssh-agent with my private key
if [ -z "$SSH_AUTH_SOCK" ] ; then eval `ssh-agent -s` && ssh-add; fi

# If installed, use pyenv python
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi

# Aliases for Oden
alias qa="gcloud config set project oden-qa \
       && gcloud container clusters get-credentials services-1 --zone us-east1-d --project oden-qa \
       && export DRONE_SERVER=https://drone.oden-qa.io"
alias prod="gcloud config set project oden-production \
       && gcloud container clusters get-credentials services-1 --zone us-east1-d --project oden-production \
       && export DRONE_SERVER=https://drone.oden.io"
alias drone="open https://drone.oden-qa.io/OdenTech/$(basename $PWD)"
alias cg="cd $HOME/go/src/github.com/OdenTech/"
