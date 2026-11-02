#!/usr/bin/env bash
# lemonOS - Copyright (C) 2026 TheMangoDeveloper. Licensed under GPL-3.0-or-later; see LICENSE.
# Make the system identify as lemonOS. Debian's version fields are kept because apt and scripts rely on them.
set -e
V="$(lemon version 2>/dev/null || echo 0.2.0)"
SRC="$(readlink -f /etc/os-release)"
[ -f "$SRC.debian" ] || cp "$SRC" "$SRC.debian"   # original, used by --undo
if [ "${1:-}" = "--undo" ]; then
  cp "$SRC.debian" "$SRC"; rm -f /etc/lemonos-release
  [ -f /etc/lsb-release.orig ] && mv /etc/lsb-release.orig /etc/lsb-release; echo "Debian identity restored"; exit 0
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
