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
export HISTSIZE=5000000
export HISTFILESIZE=5000000
export HISTFILE=~/.zsh_history

# Set the default editor to vim
export EDITOR=vim

# Set the PS1
function shortDirs {
	echo -n "$(dirs | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')"
}

function gcpProject {
	if [ -f ~/.config/gcloud/active_config ]; then
		local project=$(cat ~/.config/gcloud/active_config | xargs -I{} grep project ~/.config/gcloud/configurations/config_{} | cut -d ' ' -f 3)
		local project=$(echo $project | sed -e 's/^oden-//')  # cut the "oden-" prefix
		echo -n "[$project]"
	fi
}

function getPS1 {
 	ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
	echo -e "$(gcpProject) $(shortDirs)$ref 🔥 "
}

export PS1="$(getPS1)"

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

# if installed, use pyenv python
if command -v pyenv 1>/dev/null 2>&1; then eval "$(pyenv init -)"; fi
if command -v pyenv-virtualenv 1>/dev/null 2>&1; then eval "$(pyenv virtualenv-init -)"; fi

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
