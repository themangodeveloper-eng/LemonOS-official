#!/data/data/com.termux/files/usr/bin/bash
# lemonOS - Copyright (C) 2026 TheMangoDeveloper. Licensed under GPL-3.0-or-later; see LICENSE.
# lemonOS installer - run inside Termux
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
NAME="lemonos"

echo "🍋 Installing lemonOS..."
pkg update -y
pkg install -y proot-distro curl git

# Ask proot-distro itself whether the container exists (works across versions)
if proot-distro login "$NAME" -- true >/dev/null 2>&1; then
  echo "lemonOS already installed, updating its files."
else
  # newer proot-distro uses --name, older versions use --override-alias
  if proot-distro install --help 2>&1 | grep -q -- '--name'; then
    out=$(proot-distro install debian --name "$NAME" 2>&1) || rc=$?
  else
    out=$(proot-distro install debian --override-alias "$NAME" 2>&1) || rc=$?
  fi
  echo "$out"
  if [ "${rc:-0}" -ne 0 ] && ! echo "$out" | grep -qi "already exists"; then
    echo "Install failed, see the message above."; exit 1
  fi
fi

proot-distro login "$NAME" --bind "$DIR/rootfs:/mnt/lemon" -- bash -c '
  set -e
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends ca-certificates curl gnupg jq nano htop less
  mkdir -p /etc/lemonos
  cp -r /mnt/lemon/* /
  chmod +x /usr/local/bin/lemon /usr/local/bin/lemon-ai /usr/local/bin/lemon-boost
  chmod +x /usr/local/share/lemonos/mods/*.sh /usr/local/share/lemonos/brand.sh
  lemon boost
  lemon brand
'

mkdir -p "$PREFIX/bin"
cp "$DIR/start-lemonos.sh" "$PREFIX/bin/lemonos"
chmod +x "$PREFIX/bin/lemonos"

echo
echo "✅ Done. Start it with:  lemonos"
