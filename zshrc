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

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

function getPS1 {
	_EXIT="$?" # Last command's exit status
	_ENV="${CLOUDSDK_ACTIVE_CONFIG_NAME}"

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
		CLOSE_CHAR="𐄂"
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

export CLOUDSDK_PYTHON=/Users/devon/.pyenv/shims/python3

# if installed, use jenv for java
if command -v jenv 1>/dev/null 2>&1; then eval "$(jenv init -)"; fi

# A couple more aliases for gcp
alias personal="gcloud config set project fluted-current-229319"
alias gssh="gcloud alpha cloud-shell ssh"
alias g="gcloud"
alias code="code-insiders"

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
	while read line; do
		osascript -e "display notification \"$line\" with title \"notify\" sound name \"Submarine\""
	done
}
