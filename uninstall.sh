#!/data/data/com.termux/files/usr/bin/bash
# lemonOS - Copyright (C) 2026 TheMangoDeveloper. Licensed under GPL-3.0-or-later; see LICENSE.
read -rp "Remove lemonOS and all its data? [y/N] " a
[ "$a" = "y" ] || exit 0
proot-distro remove lemonos
rm -f "$PREFIX/bin/lemonos"
echo "lemonOS removed."
