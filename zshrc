# for go
export PATH="$PATH:$HOME/go/bin"

# for vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# sbin
export PATH="$PATH:/usr/local/sbin"

# for jenv
export PATH="$HOME/.jenv/bin:$PATH"

# Fix ctrl-r in zsh
bindkey "^R" history-incremental-pattern-search-backward

# Fix ctrl-x-e in zsh
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Set history size to something large
export SAVEHIST=5000000
export HISTSIZE=5000000
export HISTFILESIZE=5000000
export HISTFILE=~/.zsh_history

# Make sure history updates between tmux panes
export PROMPT_COMMAND="history -a; history -n"

# Set the default editor to vim
export EDITOR=vim

# Set the PS1
function shortDirs {
	echo -n "$(dirs | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')"
}

function branch {
	ref=$(git symbolic-ref HEAD 2>/dev/null | sed 's/refs\/heads\///g')
	if [ -z "$ref" ]; then
		echo -n ""
	else
		echo -n " ($ref)"
	fi
}

function getPS1 {
 	ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
	echo -e "[${CLOUDSDK_ACTIVE_CONFIG_NAME}] $(shortDirs)$(branch) 🔥 "
}

setopt PROMPT_SUBST
export PS1="\$(getPS1)"

# 256 colors in tmux
alias tmux="tmux -2"

# shortcuts for common tools
alias k="kubectl"
alias p="poetry run ipython"

# If macvim is installed, use it instead of system vim
if command -v mvim 1>/dev/null 2>&1; then alias vim='mvim -v'; fi

# setup ssh-agent with my private key
if [ -z "$SSH_AUTH_SOCK" ] ; then eval `ssh-agent -s` && ssh-add; fi

export CLOUDSDK_PYTHON=/Users/devon/.pyenv/shims/python3

# if installed, use jenv for java
if command -v jenv 1>/dev/null 2>&1; then eval "$(jenv init -)"; fi

# A couple more aliases for gcp
alias personal="gcloud config set project fluted-current-229319"
alias gssh="gcloud alpha cloud-shell ssh"
alias g="gcloud"

# Custom functions for working with gcp
function dall {
	docker $@ $(docker ps -q)
}

function mktestsub {
	gcloud pubsub subscriptions create $(whoami)-test-${1} --topic=$1 --expiration-period=7d --message-retention-duration=1d
}

function rmtestsub {
	gcloud pubsub subscriptions delete $(whoami)-test-${1}
}

function pull {
	while True; do
		gcloud pubsub subscriptions pull ${1} --limit=100000 | cut -d ' ' -f 2 | grep {
	done
}

function podlogs {
	gcloud logging read resource.labels.pod_name=${1} --format='value(jsonPayload.message)'
}

function whiletrue {
	while true; do bash -c "$@"; done
}

function ifdiff {
	lastline=""
	while read line; do
		if [[ "${line}" != "${lastline}" ]]; then
			echo $line
		fi
		lastline="${line}"
	done
}

function notify {
	local INPUT="$([[ -p /dev/stdin ]] && cat - || echo "$@")"
	osascript -e "display notification \"$INPUT\" with title \"notify\" sound name \"Submarine\""
}
