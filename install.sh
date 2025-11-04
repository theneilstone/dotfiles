#!/bin/bash

set -e


# Detect if running as root, set SUDO variable
if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    if command -v sudo >/dev/null 2>&1; then
        SUDO="sudo"
    else
        echo "Error: sudo is not available and you are not root. Please install sudo or run as root."
        exit 1
    fi
fi

setup_proxy() {
    # $1: proxy server (e.g., http://proxy.example.com:8080)
    local PROXY="$1"
    if [ -z "$PROXY" ]; then
        echo "No proxy provided, skipping proxy setup."
        return
    fi
    # Check if proxy settings are already in .bashrc
    if grep -q "export http_proxy=" "$HOME/.bashrc"; then
        echo "Proxy settings already exist in .bashrc"
        return
    fi
    {
        echo ""
        echo "# Proxy settings"
        echo "export http_proxy=\"$PROXY\""
        echo "export https_proxy=\"$PROXY\""
        echo "export ftp_proxy=\"$PROXY\""
        echo "export no_proxy=\"localhost,127.0.0.1\""
    } >> "$HOME/.bashrc"
    echo "Proxy settings added to .bashrc"
}

setup_packages() {
    # Detect operating system and install common packages using the appropriate package manager
    OS="$(uname -s)"
    if [ "$OS" = "Darwin" ]; then
        # macOS: Use Homebrew
        if ! command -v brew >/dev/null 2>&1; then
            echo "Homebrew not found, installing..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew update
        brew install git curl vim bat unzip tree tmux ripgrep fzf neovim wget python node tldr shellcheck
    elif [ -f /etc/debian_version ]; then
        # Debian/Ubuntu: Use apt
        $SUDO apt update
        $SUDO apt install -y git curl vim bat unzip tree tmux ripgrep fzf neovim wget python3 nodejs tldr
    elif [ -f /etc/fedora-release ]; then
        # Fedora: Use dnf
        $SUDO dnf install -y git curl vim bat unzip tree tmux ripgrep fzf neovim wget python3 nodejs tldr
    elif [ -f /etc/centos-release ]; then
        # CentOS: Use yum
        $SUDO yum install -y git curl vim bat unzip tree tmux ripgrep fzf neovim wget python3 nodejs tldr
    elif [ -f /etc/arch-release ]; then
        # Arch Linux: Use pacman
        $SUDO pacman -Sy --noconfirm git curl vim bat unzip tree tmux ripgrep fzf neovim wget python3 nodejs tldr
    else
        # Unsupported OS
        echo "Unsupported operating system. Please install git curl vim bat unzip manually."
        return 1
    fi
}

setup_dotfiles() {
    # $1: dotfiles remote repository URL
    DOTFILES_DIR="$HOME/.dotfiles"
    GIT_DIR="$DOTFILES_DIR"
    WORK_TREE="$HOME"

    git init --bare "$GIT_DIR"

    if ! grep -q "alias dot=" "$HOME/.bashrc"; then
        echo "alias dot='/usr/bin/git --git-dir=$GIT_DIR --work-tree=$WORK_TREE'" >> "$HOME/.bashrc"
    fi

    /usr/bin/git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" config --local status.showUntrackedFiles no

    local REMOTE_URL="$1"
    if [ -z "$REMOTE_URL" ]; then
        echo "No dotfiles remote repository URL provided, skipping remote setup."
    else
        /usr/bin/git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" remote add origin "$REMOTE_URL"
        /usr/bin/git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" fetch origin
    fi

    # Always create and checkout local main branch from origin/main, move conflicting files if needed
    TMP_BACKUP="$HOME/.dotfiles-backup-$(date +%s)"
    mkdir -p "$TMP_BACKUP"
        # Try to checkout main, capture all files that would be overwritten (untracked or tracked)
        CHECKOUT_OUTPUT=$(/usr/bin/git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" checkout -B main origin/main 2>&1)
        # Only move lines that look like dotfiles (start with a dot)
        CONFLICTS=$(echo "$CHECKOUT_OUTPUT" | awk '/would be overwritten by checkout:/{flag=1; next} /Aborting/{flag=0} flag && $1 ~ /^\./ {print $1}')
        if [ -n "$CONFLICTS" ]; then
            echo "The following files have conflicts and will be moved to $TMP_BACKUP:"
            echo "$CONFLICTS"
            while read -r file; do
                mv "$HOME/$file" "$TMP_BACKUP/"
            done <<< "$CONFLICTS"
            # Try checkout again after moving conflicts
            /usr/bin/git --git-dir="$GIT_DIR" --work-tree="$WORK_TREE" checkout -B main origin/main
        fi

    if [ -f "$HOME/.config/exclude" ]; then
        mkdir -p "$DOTFILES_DIR/info"
        cp "$HOME/.config/exclude" "$DOTFILES_DIR/info/exclude"
    else
        echo "Warning: $HOME/.config/exclude not found, skip copying."
    fi

    echo "Setup complete. Please restart your terminal or run 'source ~/.bashrc' to use the 'dot' command."
    echo "Common commands:"
    echo "  dot status"
    echo "  dot add <file>"
    echo "  dot commit -m 'message'"
    echo "  dot push"
    if [ -n "$CONFLICTS" ]; then
        echo "Conflicting files have been moved to: $TMP_BACKUP"
    fi
}


# Parse arguments: --proxy and --repo
PROXY_ARG=""
REPO_ARG="https://github.com/theneilstone/dotfiles.git"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --proxy)
            PROXY_ARG="$2"
            shift 2
            ;;
        --repo)
            REPO_ARG="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

if [ -n "$PROXY_ARG" ]; then
    setup_proxy "$PROXY_ARG" || { echo "Failed to set up proxy. Exiting."; exit 1; }
else
    echo "No proxy specified, skipping proxy setup."
fi
setup_packages || { echo "Failed to install required packages. Exiting."; exit 1; }
setup_dotfiles "$REPO_ARG" || { echo "Failed to set up dotfiles. Exiting."; exit 1; }