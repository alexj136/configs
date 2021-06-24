# ~/.bash_aliases

# Run gnome-keyring-daemon to unlock ssh keys when connecting to a server.
if [ -x "$(command -v gnome-keyring-daemon)" -a -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start --components=ssh)
    export SSH_AUTH_SOCK
fi

# General aliases
alias ls='ls --color=auto'      # Pretty colours for ls
alias grep='grep --color=auto'  # Likewise for grep
alias diff='diff --color=auto'  # Likewise for diff
alias :q='exit'                 # Quit like it's vim
alias vim='nvim'                # Use neovim
alias :e='nvim'                 # Edit like it's (n)vim
alias tmux='tmux -2'            # Force tmux to use 256 colours
function pcp {
    python -c "from math import *; from random import *; print($@)"
}

# Git command aliases
alias gst='git status -u'
alias gpl='git pull'
alias gps='git push'
alias gcm='git commit -m'
alias gd='cd $(git rev-parse --show-toplevel)'
function glg {
    git --no-pager log --reverse --pretty=format:'%C(red)%h%C(reset)%C(yellow)%d%C(reset) %C(green)(%cr) %C(blue)<%an>%C(reset)%n%s' --abbrev-commit $@
    echo ""
}
function gdf {
    if [ "$1" == "--branch" ]; then
        GDF_BRANCH_MODE="master...$(git symbolic-ref --short HEAD)"
        shift
    fi
    git --no-pager diff $@ --color=always $GDF_BRANCH_MODE | less -R --quit-if-one-screen
    unset GDF_BRANCH_MODE
}

# Use (n)vim please
export EDITOR=vim
export VISUAL="$EDITOR"
