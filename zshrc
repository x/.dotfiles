# If not calling this from the Oden Profile, source the Oden Profile
if [ "${BASH_SOURCE[0]}" = "" ]; then
	. ~/.oden_profile
fi

# for go
export PATH="$PATH:$HOME/go/bin"

# for vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Add arm homebrew to the path
export PATH="$PATH:/opt/homebrew/bin"

# sbin
#export PATH="$PATH:/usr/local/sbin"

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

# Use fzf for history
FZF_CTRL_R_OPTS='--height=100% --layout=default --border=rounded --info=hidden --color fg:188,hl:103,fg+:222,bg+:234,hl+:104'

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
	_EXIT="$?" # Last command's exit status
	_ENV="${CLOUDSDK_ACTIVE_CONFIG_NAME}"

	# Add knamespace if in a non-default knamespace
	if [ "${KUBECTL_NAMESPACE}" ] && [ $KUBECTL_NAMESPACE != 'default' ]; then
		_ENV="$_ENV∣$KUBECTL_NAMESPACE"
	fi

	# Add Python venv if in a virtual env
	if [ "${VIRTUAL_ENV}" ]; then
		local _VENV="$(basename "${VIRTUAL_ENV}")"
		_ENV="$_ENV∣$_VENV"
	fi

	_PS1="[$_ENV] $(shortDirs)"

	# Add git if in a git repo
	_REF=$(git symbolic-ref HEAD 2>/dev/null | sed 's/refs\/heads\///g')
	if [ "$_REF" ]; then
		_PS1="$_PS1 ($_REF)"
	fi

	# Pick the exit color
    if [[ "$_EXIT" == 0 ]]; then
		CLOSE_CHAR="$"
	else
		CLOSE_CHAR="☭"
	fi

	# Add closing char
	_PS1="$_PS1 ${CLOSE_CHAR} "

	echo -e "$_PS1"
}

setopt PROMPT_SUBST
export PS1="\$(getPS1)"

# 256 colors in tmux
alias tmux="tmux -2"

# Alias vim to neovim if available
if command -v nvim 1>/dev/null 2>&1; then alias vim='nvim'; fi

# Alias alphabet
alias c="cat"
alias d="docker"
alias g="git"
alias k="kubectl"
alias p="poetry run ipython"
alias t="tmux"
alias v="vim"

# setup ssh-agent with my private key
if [ -z "$SSH_AUTH_SOCK" ]; then eval $(ssh-agent -s) && ssh-add; fi

#export CLOUDSDK_PYTHON=/Users/devon/.pyenv/shims/python3

# if installed, use jenv for java
if command -v jenv 1>/dev/null 3>&1; then eval "$(jenv init -)"; fi

# A couple more aliases for gcp
alias personal="gcloud config set project fluted-current-229319"
alias gssh="gcloud alpha cloud-shell ssh"
alias g="gcloud"
alias code="code-insiders"

# Personal GCP
function personal_gcp(){
  log info "Connecting to personal project fluted-current-229319"
  export CLOUDSDK_ACTIVE_CONFIG_NAME=qa \
    && export SERVER_ENV=personal \
    && export PROJECT_ID=fluted-current-229319 \
    && export GCP_PROJECT=fluted-current-229319 #\
    #&& export GCP_REGION=${QA_REGION} \
    #&& export REGION=${QA_REGION} \
    #&& kcreds services-1
  #if [[ -f "${HOME}/.pgpass_qa" ]]; then
  #  export PGPASSFILE="${HOME}/.pgpass_qa"
  #fi
}


# Custom functions for working with gcp
function dall {
	docker $@ $(docker ps -q)
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
	while read line; do
		osascript -e "display notification \"$line\" with title \"notify\" sound name \"Submarine\""
	done
}

alias fixlogs="sudo chmod -R 777 /Users/devon/.config/gcloud/logs"


function mknamedtestsub {
  gcloud pubsub subscriptions create "${USER}-test-${1}-${2}" --topic="${1}" --expiration-period=7d --message-retention-duration=1h --labels="billing_component=testing,user=${USER}"
}
