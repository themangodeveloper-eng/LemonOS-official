# lemonOS login banner
if [ -t 1 ] && [ -z "${LEMON_BANNER_SHOWN:-}" ]; then
  export LEMON_BANNER_SHOWN=1
  echo "🍋 lemonOS $(lemon version 2>/dev/null)  |  lemon help · lemon ai · lemon boost"
fi
export PS1='\[\e[1;33m\]lemon\[\e[0m\]:\w\$ '

# neofetch with the lemon logo
if command -v neofetch >/dev/null 2>&1; then
  neofetch() { command neofetch --source /usr/local/share/lemonos/logo.txt --ascii_colors 3 2 "$@"; }
fi
