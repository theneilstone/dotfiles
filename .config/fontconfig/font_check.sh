#!/bin/bash
config="$(dirname "$0")/font.conf"
exclude="sans-serif|serif|monospace|system-ui"

awk '/<edit name="family"/,/<\/edit>/' "$config" | \
awk -F'[<>]' '/<string>/ {print $3}' | \
sort | uniq | \
grep -Ev -i "^($exclude)$" | \
while read -r font; do
  if fc-list | grep -i "$font" > /dev/null; then
    printf "%-30s : Installed\n" "$font"
  else
    printf "%-30s : Not installed\n" "$font"
  fi
done