# for go

export PATH="$PATH:$HOME/go/bin"

# for vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# sbin
export PATH="$PATH:/usr/local/sbin"

# temporary hack for terraform
export PATH="/usr/local/opt/terraform@0.11/bin:$PATH"

# for jenv
export PATH="$HOME/.jenv/bin:$PATH"

# for gcloud
if [ -d /usr/local/Caskroom/google-cloud-sdk/ ]; then
	. /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
	. /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
fi

export HISTSIZE=5000000
export HISTFILESIZE=5000000
export EDITOR=vim

# git bash autocomplete
if [ -f `brew --prefix`/etc/bash_completion ]; then
	source `brew --prefix`/etc/bash_completion
fi

function shortDirs {
	echo -n "$(dirs | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')"
}

function odenGCPProject {
	if [ -f ~/.config/gcloud/active_config ]; then
		local project=$(cat ~/.config/gcloud/active_config | xargs -I{} grep project ~/.config/gcloud/configurations/config_{} | cut -d ' ' -f 3)
		local project=$(echo $project | sed -e 's/^oden-//')  # cut the "oden-" prefix
		echo -n "[$project]"
	fi
}

function getPS1 {
	a="$(odenGCPProject) $(shortDirs)$(__git_ps1)"
	b="🔥 "
	cols=$(tput cols)
	if [ $cols -gt 70 ]; then
		echo -e "$a $b"
	else
		echo -e "$b"
	fi
}

export PS1="\$(getPS1)"

# 256 colors in tmux
alias tmux="tmux -2"

# shortcuts for common tools
alias v="vagrant"
alias k="kubectl"
alias p="poetry run ipython"

# setup ssh-agent with my private key
if [ -z "$SSH_AUTH_SOCK" ] ; then eval `ssh-agent -s` && ssh-add; fi

export CLOUDSDK_PYTHON=/Users/devon/.pyenv/shims/python3

# if installed, use pyenv python
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
if command -v pyenv-virtualenv 1>/dev/null 2>&1; then eval "$(pyenv virtualenv-init -)"; fi

# if installed, use jenv for java
if command -v jenv 1>/dev/null 2>&1; then eval "$(jenv init -)"; fi

# oden aliases
alias qa="gcloud config set project oden-qa \
	&& gcloud container clusters get-credentials services-1 --zone us-east1 --project oden-qa"
alias prod="gcloud config set project oden-production \
       && gcloud container clusters get-credentials services-1 --zone us-central1 --project oden-production"
alias personal="gcloud config set project fluted-current-229319"
alias cg="cd `git rev-parse --show-toplevel`"
alias watchbuild="gcloud builds list --ongoing | head -2 | tail -1 | cut -d ' ' -f 1 | xargs -I{} gcloud builds log --stream {}"
alias gssh="gcloud alpha cloud-shell ssh"
alias kf="sudo CLOUDSDK_PYTHON=/usr/bin/python kubefwd svc -n default -d internal.oden-qa.io"
alias g="gcloud"

# Oden env stuff
source ~/src/dotfiles/base/env

# Custom functions
function dall {
	docker $@ $(docker ps -q)
}

function mktestsub {
	gcloud pubsub subscriptions create $(whoami)-test-${1} --topic=$1 --expiration-period=1d --message-retention-duration=30m
}

function rmtestsub {
	gcloud pubsub subscriptions delete $(whoami)-test-${1}
}

function pull {
	while True; do
		gcloud pubsub subscriptions pull ${1} --limit=100000 | cut -d ' ' -f 2 | grep {
	done
}

function lookup-machine {
	bq query --nouse_legacy_sql --format=json "SELECT line.factory_id, device.* FROM \`primary.external__device\` device JOIN \`primary.external__machinegroup_line\` line ON line.machinegroup_id = device.machinegroup WHERE device.uuid = '${1}'" | jq '.'
}
