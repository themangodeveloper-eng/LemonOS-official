#!/data/data/com.termux/files/usr/bin/bash
# lemonOS - Copyright (C) 2026 TheMangoDeveloper. Licensed under GPL-3.0-or-later; see LICENSE.
# Launch lemonOS (installed as the `lemonos` command)
exec proot-distro login lemonos --shared-tmp --user root "$@"
