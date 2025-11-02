#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# XDG
# export XDG_CONFIG_HOME=~/.config
# export XDG_CACHE_HOME=~/.cache
# export XDG_DATA_HOME=~/.data
# export XDG_STATE_HOME=~/.state

# Color
export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Path
export PATH=/opt/homebrew/bin:/opt/homebrew/opt/curl/bin:$PATH
export PATH=/Users/ander/.local/bin:$PATH

# java environment manager jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
