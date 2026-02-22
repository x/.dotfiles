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

# Prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PS1_AWS=${PS1_AWS:-0}
export PS1_GCP=${PS1_GCP:-0}
export PS1_KUBE=${PS1_KUBE:-0}
export PS1_PYTHON=${PS1_PYTHON:-0}
export PS1_GIT=${PS1_GIT:-1}

if [[ -f /opt/homebrew/share/kube-ps1.sh ]]; then
	source /opt/homebrew/share/kube-ps1.sh
	export KUBE_PS1_PREFIX="" KUBE_PS1_SUFFIX="" KUBE_PS1_SEPARATOR=""
	export KUBE_PS1_SYMBOL_ENABLE=false KUBE_PS1_HIDE_IF_NOCONTEXT=true
	export KUBE_PS1_NS_ENABLE=false
	export KUBE_PS1_CTX_COLOR="" KUBE_PS1_NS_COLOR=""
	_kube_ctx_short() { echo "${1##*/}"; }
	export KUBE_PS1_CLUSTER_FUNCTION=_kube_ctx_short
fi

printPs1() {
	local x=$? e="" d=$'\x1b[2m' r=$'\x1b[0m'
	if [[ "$PS1_AWS" == 1 ]]; then
		[[ -n "$AWS_PROFILE" && "$AWS_PROFILE" != "default" ]] && e+="%{${d}%}\ue7ad %{${r}%}$AWS_PROFILE"
	fi
	if [[ "$PS1_GCP" == 1 ]]; then
		local gcp=$(cat ~/.config/gcloud/active_config 2>/dev/null)
		[[ -n "$gcp" && "$gcp" != "default" ]] && e+="${e:+ }%{${d}%}󱇶 %{${r}%}$gcp"
	fi
	if [[ "$PS1_KUBE" == 1 ]] && command -v kube_ps1 &>/dev/null; then
		e+="${e:+ }%{${d}%}\ue81d %{${r}%}$(kube_ps1)"
	fi
	if [[ "$PS1_PYTHON" == 1 ]]; then
		if [[ -n "$VIRTUAL_ENV" ]]; then
			e+="${e:+ }%{${d}%}\ue606 %{${r}%}$(basename "$(dirname "$VIRTUAL_ENV")"):$("$VIRTUAL_ENV/bin/python" --version 2>&1 | cut -d' ' -f2)"
		elif command -v pyenv &>/dev/null; then
			e+="${e:+ }%{${d}%}\ue606 %{${r}%}$(pyenv version | cut -d' ' -f1)"
		fi
	fi
	if [[ "$PS1_GIT" == 1 ]]; then
		local b=$(git symbolic-ref --short HEAD 2>/dev/null)
		[[ -n "$b" ]] && e+="${e:+ }%{${d}%}\ue725 %{${r}%}$b"
	fi
	echo -e "${e:+$e }$(dirs) $([[ $x == 0 ]] && echo '$' || echo '\uf467') "
}

ps1config() {
	local names=("aws" "gcp" "kube" "python" "git")
	local vars=(PS1_AWS PS1_GCP PS1_KUBE PS1_PYTHON PS1_GIT)
	local bind_str=""
	for i in {1..${#names[@]}}; do
		[[ "${(P)vars[$i]}" == 1 ]] && bind_str+="toggle+"
		(( i < ${#names[@]} )) && bind_str+="down+"
	done
	bind_str+="first"
	local result
	result=$(printf '%s\n' "${names[@]}" | \
		fzf --multi --no-sort --height=8 --reverse \
			--header "Tab=toggle  Enter=apply  Esc=cancel" \
			--bind "load:${bind_str}")
	[[ $? -ne 0 ]] && return
	for v in "${vars[@]}"; do export "$v=0"; done
	while IFS= read -r line; do
		case "$line" in
			aws) export PS1_AWS=1 ;; gcp) export PS1_GCP=1 ;;
			kube) export PS1_KUBE=1 ;; python) export PS1_PYTHON=1 ;;
			git) export PS1_GIT=1 ;;
		esac
	done <<< "$result"
}

setopt PROMPT_SUBST
export PS1='$(printPs1)'

# Shortcut for ipython, can also execute like python
alias p="uv run ipython"

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
