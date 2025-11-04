#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# --- Configurable Section ---
SOFTWARE_LIST=(
  "git:macos,centos,arch"
  "neovim:macos,centos,arch"
  "tmux:macos,centos,arch"
  "python:macos,arch"
  "python3:centos"
  "node:macos"
  "nodejs:centos,arch"
  "fzf:macos,centos,arch"
  "ripgrep:macos,centos,arch"
  "wget:macos,centos,arch"
  "htop:macos,centos,arch"
  "tree:macos,centos,arch"
  "docker:macos,centos,arch"
)
DEFAULT_DOTFILES_REPO="https://github.com/theneilsthon/dotfiles.git"
LOG_FILE="$HOME/install.log"

# --- Utility Functions ---
cecho() { local c="$1"; shift; case "$c" in red) echo -e "\033[31m$*\033[0m";; green) echo -e "\033[32m$*\033[0m";; yellow) echo -e "\033[33m$*\033[0m";; blue) echo -e "\033[34m$*\033[0m";; *) echo "$*";; esac; }
log()   { echo "[$(date '+%F %T')] $*" >> "$LOG_FILE"; }
run()   { cecho blue "$*"; log "$*"; ((DRY_RUN)) || eval "$*"; }

# --- OS Detection & Package List ---
get_os() {
  [[ "$OSTYPE" == "darwin"* ]] && echo macos && return
  [[ -f /etc/centos-release ]] && echo centos && return
  [[ -f /etc/arch-release ]] && echo arch && return
  # Detect WSL (Windows Subsystem for Linux)
  if grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null; then
    if grep -qi arch /etc/os-release 2>/dev/null; then
      echo wsl-arch
      return
    fi
    # Add more WSL-distro detection here if needed
    echo wsl
    return
  fi
  echo unsupported
}
get_pkgs() {
  local os="$1"; local out=();
  for entry in "${SOFTWARE_LIST[@]}"; do
    local pkg="${entry%%:*}"; local oslist="${entry#*:}"
    [[ ",${oslist}," == *",${os},"* ]] && out+=("$pkg")
  done
  local conf="$HOME/.install-extra-packages-$os.conf"
  [[ -f "$conf" ]] && out+=( $(grep -v '^#' "$conf" | grep -v '^$') )
  echo "${out[@]}"
}

is_installed() {
  local pkg="$1" os="$2"
  case "$os" in
    macos) brew list --formula | grep -qw "$pkg" ;;
    centos) rpm -q "$pkg" &>/dev/null ;;
    arch) pacman -Q "$pkg" &>/dev/null ;;
    *) return 1 ;;
  esac
}

# --- Core Actions ---
install_software() {
  local os="$1"
  # Prepare package manager and update system before installing packages
  case "$os" in
    macos)
      command -v brew &>/dev/null || run '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
      run brew update
      ;;
    centos)
      run sudo yum makecache fast
      run sudo yum install -y epel-release
      ;;
    arch|wsl-arch)
      run sudo pacman -Sy --noconfirm
      ;;
    wsl)
      run sudo apt-get update
      ;;
  esac
  local pkgs=( $(get_pkgs "$os") ); local to_install=()
  for pkg in "${pkgs[@]}"; do is_installed "$pkg" "$os" || to_install+=("$pkg"); done
  [[ ${#to_install[@]} -eq 0 ]] && cecho green "All packages already installed." && return
  case "$os" in
    macos) run brew install "${to_install[*]}" ;;
    centos) run sudo yum install -y "${to_install[*]}" ;;
    arch|wsl-arch) run sudo pacman -S --noconfirm "${to_install[*]}" ;;
    wsl) run sudo apt-get install -y "${to_install[*]}" ;;
  esac
}
setup_dotfiles() {
  local repo="${1:-$DEFAULT_DOTFILES_REPO}"; local mode="${2:-backup}"
  local dir="$HOME/.dotfiles"; local backup="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"
  command -v git &>/dev/null || install_software "$os_name" "git"
  if [[ -d "$dir" ]]; then
    [[ "$mode" == pull ]] && run git --git-dir="$dir" --work-tree="$HOME" pull && return
    cecho yellow "Dotfiles repo exists at $dir. Skipping clone."
  else
    run git clone --bare "$repo" "$dir"
  fi
  cecho blue "Checking out dotfiles..."
  local conflicts=$(git --git-dir="$dir" --work-tree="$HOME" checkout 2>&1 | grep -E "^\s+" | sed 's/^ *//')
  if [[ -n "$conflicts" ]]; then
    case "$mode" in
      force) cecho red "Removing conflicting files..."; for f in $conflicts; do run rm -rf "$HOME/$f"; done ;;
      skip)  cecho yellow "Skipping conflicting files."; return ;;
      *)     cecho yellow "Backing up conflicts to $backup"; mkdir -p "$backup"; for f in $conflicts; do run mv "$HOME/$f" "$backup/" 2>/dev/null || true; done ;;
    esac
    run git --git-dir="$dir" --work-tree="$HOME" checkout
  fi
  run git --git-dir="$dir" --work-tree="$HOME" config --local status.showUntrackedFiles no
  cecho green "Dotfiles setup complete."
}

# --- Argument Parsing ---
usage() {
  cat <<EOF
Usage: $0 [--init] [--install] [--dotfiles] [--all] [--repo URL] [--mode backup|force|skip|pull] [--dry-run] [--help]
  --init         Install package manager and update system
  --install      Install common development packages (auto skip installed, support extra conf)
  --dotfiles     Setup dotfiles (optionally pass --repo and --mode)
  --all          Run all steps (default repo and backup mode unless specified)
  --repo URL     Specify dotfiles repo URL
  --mode MODE    Dotfiles mode: backup|force|skip|pull
  --dry-run      Only print what would be done, do not execute
  --help         Show this help message
EOF
}

main() {
  local do_init=0 do_install=0 do_dotfiles=0 do_all=0 repo="" mode="backup"; DRY_RUN=0
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --init) do_init=1 ;;
      --install) do_install=1 ;;
      --dotfiles) do_dotfiles=1 ;;
      --repo) repo="$2"; shift ;;
      --mode) mode="$2"; shift ;;
      --dry-run) DRY_RUN=1 ;;
      -h|--help) usage; exit 0 ;;
      *) usage; exit 1 ;;
    esac
    shift
  done
  os_name=$(get_os)
  [[ "$os_name" == "unsupported" ]] && cecho red "Unsupported OS." && exit 1
  : > "$LOG_FILE"
  if ((do_init)); then
    cecho blue "[init]"
    install_software "$os_name"
    setup_dotfiles "$repo" "$mode"
  fi
  ((do_install)) && cecho blue "[install]" && install_software "$os_name"
  ((do_dotfiles)) && cecho blue "[dotfiles]" && setup_dotfiles "$repo" "$mode"
  if ! ((do_init || do_install || do_dotfiles || do_all)); then usage; exit 1; fi
  cecho green "Done. Log: $LOG_FILE"
}

main "$@"