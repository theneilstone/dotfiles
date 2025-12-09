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


if [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
fi
if [[ ":$PATH:" != *":/opt/homebrew/opt/curl/bin:"* ]]; then
	export PATH="/opt/homebrew/opt/curl/bin:$PATH"
fi
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi
if [[ ":$PATH:" != *":$HOME/.asdf/shims:$PATH"* ]]; then
    export PATH="$HOME/.asdf/shims:$PATH"
fi