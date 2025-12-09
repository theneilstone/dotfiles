#
# ~/.bashrc
#


# If not running interactively, don't do anything
[[ $- != *i* ]] && return


_prompt_short_pwd () {
        [[ $PWD == "/" ]] && { printf "/"; return; }
        IFS="/" read -ra parts <<< "${PWD#/}"
        local len=${#parts[@]}
        local last=${parts[len-1]}
        (( len <= 2 )) && { printf "/%s" "$last"; return; }
        local short=""
        for ((i=0; i<len-1; i++)); do
                short+="/${parts[i]:0:1}"
        done
        printf "%s/%s" "$short" "$last"
}

_prompt_git_branch () {
        local branch=""
        if command -v git >/dev/null 2>&1; then
                branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        fi
        [[ -n $branch && $branch != "HEAD" ]] && printf " (%s)" "$branch"
}

_prompt_git_changes () {
        if ! command -v git >/dev/null 2>&1; then
                return
        fi
        local staged unstaged
        staged=$(git status --porcelain 2>/dev/null | awk '{ if (substr($0,1,1) != " " && substr($0,1,1) != "?") print }' | wc -l | tr -d ' ')
        unstaged=$(git status --porcelain 2>/dev/null | awk '{ if (substr($0,2,1) != " ") print }' | wc -l | tr -d ' ')
        if (( staged == 0 && unstaged == 0 )); then
                return
        fi
        printf " %s/%s" "$staged" "$unstaged"
}

PS1="\[\033[38;5;69m\]\u@\h\[\033[m\] \[\033[38;5;34m\]\$(_prompt_short_pwd)\[\033[m\]\[\033[38;5;154m\]\$(_prompt_git_branch)\[\033[m\]\[\033[38;5;203m\]\$(_prompt_git_changes)\[\033[m\] \[\033[38;5;226m\]\$\[\033[m\] "

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias lsg='ls -A | grep -i'
alias psg='ps aux | grep -i'
alias hig='history | grep -i'
alias vim='nvim'
alias cat='bat'

# Dotfiles git alias
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# Environment variables
export GPG_TTY=$(tty)
export EDITOR='vim'
export GIT_EDITOR='vim'
export HISTCONTROL=ignoreboth


# Compile flags (uncomment if needed)
# export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/curl/include"


# Extract function for common archive formats
extract () {
        if [ $# -eq 0 ]; then
                echo "Usage: extract <file>"
                return 1
        fi
        if [ -f "$1" ] ; then
                case "$1" in
                        *.tar.bz2)   tar xjf "$1"   ;;
                        *.tar.gz)    tar xzf "$1"   ;;
                        *.bz2)       bunzip2 "$1"   ;;
                        *.rar)       rar x "$1"     ;;
                        *.gz)        gunzip "$1"    ;;
                        *.tar)       tar xf "$1"    ;;
                        *.tbz2)      tar xjf "$1"   ;;
                        *.tgz)       tar xzf "$1"   ;;
                        *.zip)       unzip "$1"     ;;
                        *.Z)         uncompress "$1";;
                        *)           echo "'$1' cannot be extracted via extract()" ;;
                esac
        else
                echo "'$1' is not a valid file"
                return 1
        fi
}


# Bash completion (macOS and Linux)
if [ -f /opt/homebrew/etc/bash_completion ]; then
        . /opt/homebrew/etc/bash_completion
elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
fi

# asdf completion: prefer static completion files (safer)
if [ -f "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf" ]; then
        . "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf"
elif [ -f "$HOME/.asdf/completions/asdf.bash" ]; then
        . "$HOME/.asdf/completions/asdf.bash"
fi