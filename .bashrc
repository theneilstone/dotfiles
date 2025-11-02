#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

_short_pwd() {
        local IFS="/"; local arr=($PWD); local n=${#arr[@]}; local out=""
        if (( n <= 2 )); then
                out="/${arr[n-1]}"
        else
                for ((i=1;i<n-1;i++)); do
                        [ -n "${arr[i]}" ] && out+="/${arr[i]:0:1}"
                done
                out+="/${arr[n-1]}"
        fi
        echo "$out"
}

PS1="\[\033[38;5;250m\]\u\[\033[m\]\[\033[38;5;252m\]@\[\033[m\]\[\033[38;5;250m\]\h\[\033[m\]:\[\033[38;5;67m\]\$(_short_pwd)\[\033[m\]\[\033[38;5;108m\]\$(__git_ps1)\[\033[m\] \$ "

# Alias
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias grep='grep --color=auto'
alias lsg='ls -A | grep -i'
alias psg='ps aux | grep -i'
alias hig='history | grep -i'
alias vim='nvim'
alias cat='bat'

## Config git alias
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Env export
export GPG_TTY=$(tty)
export EDITOR='vim'
export GIT_EDITOR='vim'
export HISTCONTROL=ignoreboth

# Compile
# export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/curl/include"

# Funcation
function extract () {
        if [ -f $1 ] ; then
                case $1 in
                        *.tar.bz2)       tar xjf $1                                    ;;
                        *.tar.gz)        tar xzf $1                                    ;;
                        *.bz2)           bunzip2 $1                                    ;;
                        *.rar)           rar x $1                                      ;;
                        *.gz)            gunzip $1                                     ;;
                        *.tar)           tar xf $1                                     ;;
                        *.tbz2)          tar xjf $1                                    ;;
                        *.tgz)           tar xzf $1                                    ;;
                        *.zip)           unzip $1                                      ;;
                        *.Z)             uncompress $1                                 ;;
                        *)               echo "'$1' cannot be extracted via extract()" ;;
                esac
        else
                echo "'$1' is not a valid file"
        fi
}

# Completion
source /opt/homebrew/etc/bash_completion
