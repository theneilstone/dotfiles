#!/bin/bash
config="$(dirname "$0")/font.conf"
exclude="sans-serif|serif|monospace|system-ui"

# Detect system type
if [[ "$OSTYPE" == "darwin"* ]]; then
  sys="mac"
elif command -v pacman >/dev/null; then
  sys="arch"
elif command -v apt >/dev/null; then
  sys="ubuntu"
elif command -v dnf >/dev/null; then
  sys="centos"
else
  sys="unknown"
fi

awk '/<edit name="family"/,/<\/edit>/' "$config" | \
awk -F'[<>]' '/<string>/ {print $3}' | \
sort | uniq | grep -Ev -i "^($exclude)$" | while read -r font; do
  if ! fc-list | grep -i "$font" > /dev/null; then
    echo "Not installed: $font"
    case "$font" in
      "Noto Sans"|"Noto Sans CJK SC"|"Noto Serif"|"Noto Serif CJK SC"|"Noto Emoji")
        case "$sys" in
          mac)
            brew install --cask font-noto-sans font-noto-serif font-noto-sans-cjk font-noto-serif-cjk font-noto-emoji
            ;;
          arch)
            sudo pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji
            ;;
          ubuntu)
            sudo apt update
            sudo apt install -y fonts-noto fonts-noto-cjk fonts-noto-color-emoji
            ;;
          centos)
            sudo dnf install -y google-noto-sans-fonts google-noto-serif-fonts google-noto-cjk-fonts google-noto-emoji-fonts
            ;;
        esac
        ;;
      "Maple Mono")
        case "$sys" in
          mac)
            brew install --cask font-maple-mono || echo "If not found, download from https://github.com/subframe7536/Maple-font"
            ;;
          *)
            echo "Please download Maple Mono from https://github.com/subframe7536/Maple-font and install manually."
            ;;
        esac
        ;;
      *)
        echo "Please install $font manually."
        ;;
    esac
  else
    echo "Installed: $font"
  fi
done
