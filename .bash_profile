#
# ~/.bash_profile
#


# Load bashrc for interactive shells
if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
fi

# XDG user directories
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.data"
    export XDG_STATE_HOME="$HOME/.state"
fi

# Terminal color settings
export BASH_SILENCE_DEPRECATION_WARNING=1  # Silence bash deprecation warning (macOS)
export CLICOLOR=1                          # Enable color output for ls
export LSCOLORS=ExFxBxDxCxegedabagacad     # Customize ls color scheme

# PATH settings (add each path separately for clarity)
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.jenv/bin:$PATH"

# jenv (Java environment manager)
if command -v jenv >/dev/null 2>&1; then
	eval "$(jenv init -)"
fi

# nvm (Node.js version manager)
export NVM_DIR="$HOME/.nvm"
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
	. "/opt/homebrew/opt/nvm/nvm.sh"
fi
if [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]; then
	. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi
