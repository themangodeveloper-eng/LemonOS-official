#!/usr/bin/env bash
# lemonOS - Copyright (C) 2026 TheMangoDeveloper. Licensed under GPL-3.0-or-later; see LICENSE.
# Make the system identify as lemonOS. Debian's version fields are kept because apt and scripts rely on them.
set -e
V="$(lemon version 2>/dev/null || echo 0.2.0-beta)"
SRC="$(readlink -f /etc/os-release)"
[ -f "$SRC.debian" ] || cp "$SRC" "$SRC.debian"   # original, used by --undo
if [ "${1:-}" = "--undo" ]; then
  cp "$SRC.debian" "$SRC"; rm -f /etc/lemonos-release
  [ -f /etc/lsb-release.orig ] && mv /etc/lsb-release.orig /etc/lsb-release
  for f in "$HOME/.config/neofetch/config.conf" "$HOME/.config/fastfetch/config.jsonc"; do
    grep -q "lemonos-managed" "$f" 2>/dev/null && rm -f "$f"
  done; echo "Debian identity restored"; exit 0
fi
BASE="$(grep -E '^(VERSION_ID|VERSION_CODENAME|VERSION|DEBIAN_CODENAME)=' "$SRC.debian" || true)"
cat > "$SRC" <<OS
PRETTY_NAME="lemonOS $V (based on Debian)"
NAME="lemonOS"
ID=lemonos
ID_LIKE=debian
$BASE
HOME_URL="https://github.com/themangodeveloper-eng/LemonOS-official"
BUG_REPORT_URL="https://github.com/themangodeveloper-eng/LemonOS-official/issues"
OS
echo "lemonOS $V (based on Debian)" > /etc/lemonos-release
# some tools (neofetch on Ubuntu-like bases) read /etc/lsb-release first
if [ -f /etc/lsb-release ]; then
  [ -f /etc/lsb-release.orig ] || cp /etc/lsb-release /etc/lsb-release.orig
  printf 'DISTRIB_ID=lemonOS\nDISTRIB_RELEASE=%s\nDISTRIB_DESCRIPTION="lemonOS %s (based on Debian)"\n' "$V" "$V" > /etc/lsb-release
fi
echo "🍋 now identifies as lemonOS (undo: lemon brand --undo)"

# --- lemon logo for neofetch / fastfetch (written to their own config files) ---
LOGO=/usr/local/share/lemonos/logo.txt
if command -v neofetch >/dev/null 2>&1; then
  C="$HOME/.config/neofetch/config.conf"
  if [ ! -f "$C" ] || grep -q "lemonos-managed" "$C"; then
    mkdir -p "$(dirname "$C")"
    { echo "# lemonos-managed (remove with: lemon brand --undo)"; neofetch --print_config; } > "$C.tmp" 2>/dev/null
    sed -i "s#^image_backend=.*#image_backend=\"ascii\"#; s#^image_source=.*#image_source=\"$LOGO\"#; s#^ascii_colors=.*#ascii_colors=(3 2)#" "$C.tmp"
    mv "$C.tmp" "$C"
    echo "🍋 neofetch will show the lemon logo"
  fi
fi
if command -v fastfetch >/dev/null 2>&1; then
  C="$HOME/.config/fastfetch/config.jsonc"
  if [ ! -f "$C" ] || grep -q "lemonos-managed" "$C"; then
    mkdir -p "$(dirname "$C")"
    cat > "$C" <<F
// lemonos-managed (remove with: lemon brand --undo)
{
  "logo": { "type": "file", "source": "/usr/local/share/lemonos/logo.fastfetch.txt", "color": { "1": "yellow", "2": "green" } }
}
F
    echo "🍋 fastfetch will show the lemon logo"
  fi
fi
