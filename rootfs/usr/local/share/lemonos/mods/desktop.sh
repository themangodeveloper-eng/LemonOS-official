#!/usr/bin/env bash
# lemonOS - Copyright (C) 2026 TheMangoDeveloper. Licensed under GPL-3.0-or-later; see LICENSE.
# lemonOS mod: XFCE desktop over TigerVNC
set -e
apt-get install -y --no-install-recommends xfce4 xfce4-terminal dbus-x11 tigervnc-standalone-server tigervnc-common
mkdir -p ~/.vnc
cat > ~/.vnc/xstartup <<'X'
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
exec startxfce4
X
chmod +x ~/.vnc/xstartup
echo "Set a VNC password:"; vncpasswd
echo "Start:  vncserver :5   then connect a VNC app to localhost:5905"
echo "Stop:   vncserver -kill :5"
