# Setttings
DEVON_SET_PS1=${DEVON_SET_PS1:-1}

# for go
export PATH="$PATH:$HOME/go/bin"

# for vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Add arm homebrew to the path
export PATH="$PATH:/opt/homebrew/bin"

# ~/.bin
export PATH="$PATH:$HOME/.bin"

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

# No bell on tab completion
unsetopt LIST_BEEP

# Set up pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -n "$(command -v pyenv)" ]] && eval "$(pyenv init - zsh)"

# Set up the PS1
function printDevonPs1 {
	_LAST_COMMAND_EXIT="$?"
	
	_SHORT_DIRS="$(dirs | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')"
	
	_ENV=""
	
	# Pyenv Python version (note: this is different from PYENV_VERSION that pyenv sets)
	if [ -n "$(command -v pyenv)" ]; then
		_ENV="${_ENV:+${_ENV}}𓆗 $(pyenv version | cut -d ' ' -f 1)"
	fi

	# UV Python version
	if uv version &>/dev/null; then
	    _UV_PY_BIN="$(uv python find)"
	    if [[ -n "$_UV_PY_BIN" ]]; then
	        _UV_PYTHON_VERSION="$("$_UV_PY_BIN" --version 2>/dev/null | cut -d ' ' -f 2)"
	        _ENV="${_ENV:+${_ENV} }𝓊 ${_UV_PYTHON_VERSION}"
	    fi
	fi

	if [ -n "${VIRTUAL_ENV}" ]; then
		_ENV="${_ENV:+${_ENV} }$𓆘 {VIRTUAL_ENV}"
	fi

	if [ -n "${_ENV}" ]; then
		#_PS1="\e[7m${_ENV}\e[27m $_SHORT_DIRS"
		_PS1="[${_ENV}] $_SHORT_DIRS"
	else
		_PS1="$_SHORT_DIRS"
	fi

	_REF=$(git symbolic-ref HEAD 2>/dev/null | sed 's/refs\/heads\///g')
	if [ "$_REF" ]; then
		_PS1="$_PS1 ($_REF)"
	fi

    if [[ "$_LAST_COMMAND_EXIT" == 0 ]]; then
		CLOSE_CHAR="$"
	else
		CLOSE_CHAR="☭"
	fi
	_PS1="$_PS1 ${CLOSE_CHAR} "

	echo -e "$_PS1"
}

if [[ "$DEVON_SET_PS1" == 1 ]]; then
	setopt PROMPT_SUBST
	export PS1="\$(printDevonPs1)"
fi

# Shortcut for ipython, can also execute like python
alias p="uv run ipython"

# Shortcut for lazydocker
alias lzd='lazydocker'

# Always color for less
export LESS='-R'

# If installed, alias cat to bat
if command -v bat 1>/dev/null 3>&1; then alias cat='bat --paging=never'; fi

# setup ssh-agent with my private key
[[ -z "${SSH_AUTH_SOCK}" ]] && eval $(ssh-agent -s) && ssh-add

function notify {
    local message="${*:-$([ $? -eq 0 ] && echo 'SUCCESS' || echo 'FAILED')}"
    osascript -e "tell application \"System Events\" to display dialog \"$message\" buttons {\"ack\"} default button \"ack\""
}
