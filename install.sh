#!/data/data/com.termux/files/usr/bin/bash
# lemonOS - Copyright (C) 2026 TheMangoDeveloper. Licensed under GPL-3.0-or-later; see LICENSE.
# lemonOS installer - run inside Termux
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
NAME="lemonos"

echo "🍋 Installing lemonOS..."
pkg update -y
pkg install -y proot-distro curl git

if proot-distro list 2>/dev/null | grep -q "$NAME"; then
  echo "lemonOS already installed, updating its files."
else
  proot-distro install debian --override-alias "$NAME"
fi

proot-distro login "$NAME" --bind "$DIR/rootfs:/mnt/lemon" -- bash -c '
  set -e
  export DEBIAN_FRONTEND=noninteractive
  apt-get update
  apt-get install -y --no-install-recommends ca-certificates curl gnupg jq nano htop less
  cp -r /mnt/lemon/* /
  chmod +x /usr/local/bin/lemon /usr/local/bin/lemon-ai /usr/local/bin/lemon-boost
  chmod +x /usr/local/share/lemonos/mods/*.sh
  lemon boost
'

mkdir -p "$PREFIX/bin"
cp "$DIR/start-lemonos.sh" "$PREFIX/bin/lemonos"
chmod +x "$PREFIX/bin/lemonos"

echo
echo "✅ Done. Start it with:  lemonos"
