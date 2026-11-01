# 🍋 lemonOS (LemonOS-official)

A Debian-based environment for Termux (via proot-distro) with its own package
manager, built-in AI assistant, and speed optimizer.

> lemonOS runs on the Android kernel inside proot. It is a full Debian userland
> with a custom layer, not a standalone OS.

## Install (in Termux)
    pkg install git -y
    git clone https://github.com/themangodeveloper-eng/LemonOS-official.git
    cd LemonOS-official
    bash install.sh
    lemonos            # launch

## Commands
    lemon install|remove|search|info|list|update|upgrade|clean
    lemon deb file.deb              install a local .deb
    lemon repo add name "URL suite comp" KEY_URL
    lemon mod desktop               XFCE + TigerVNC
    lemon ai "how do I ..."         assistant (asks before running anything)
    lemon boost [--undo]            optimizer

## AI setup
    echo 'ANTHROPIC_API_KEY=sk-ant-...' > /etc/lemonos/ai.conf
    chmod 600 /etc/lemonos/ai.conf

## Boost: what it really does
Parallel apt downloads, no translation files, no recommended packages, faster
dpkg I/O, and cache cleanup. Real gains are modest; no root means no kernel tuning.

## License
lemonOS is free software, licensed under the GNU General Public License v3.0 or later.
See the `LICENSE` file for the full text.
