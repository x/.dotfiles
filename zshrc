# for go
export PATH="$PATH:$HOME/go/bin"

# for vscode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Add arm homebrew to the path
export PATH="$PATH:/opt/homebrew/bin"

# ~/.bin
export PATH="$PATH:$HOME/.bin"

# Fix ctrl-x-e in zsh
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

# Set history size to something large (atuin is the primary store, this is a fallback)
export SAVEHIST=5000000
export HISTSIZE=5000000
export HISTFILE=~/.zsh_history
setopt SHARE_HISTORY EXTENDED_HISTORY INC_APPEND_HISTORY_TIME HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# atuin: every command from every pane, searchable via ctrl-r
eval "$(atuin init zsh --disable-up-arrow)"

# Set the default editor to nvim
export EDITOR=nvim
export vim=nvim

# No bell on tab completion
unsetopt LIST_BEEP

# Set up pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
[[ -n "$(command -v pyenv)" ]] && eval "$(pyenv init - zsh)"

eval "$(starship init zsh)"

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

alias yolo="claude --dangerously-skip-permissions"
