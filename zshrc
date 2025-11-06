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

# Set up the PS1
function getPS1 {
	_LAST_COMMAND_EXIT="$?"
	
	_SHORT_DIRS="$(dirs | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')"
	_PS1="$_SHORT_DIRS"

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
setopt PROMPT_SUBST
export PS1="\$(getPS1)"

# Shortcut for ipython, can also execute like python
alias p="uv run ipython"

# Always color for less
export LESS='-R'

# If installed, alias cat to bat
if command -v bat 1>/dev/null 3>&1; then alias cat='bat --paging=never'; fi

# setup ssh-agent with my private key
if [ -z "${SSH_AUTH_SOCK}" ]; then
	eval $(ssh-agent -s) && ssh-add;
fi
