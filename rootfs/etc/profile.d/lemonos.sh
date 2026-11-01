# lemonOS login banner
if [ -t 1 ] && [ -z "${LEMON_BANNER_SHOWN:-}" ]; then
  export LEMON_BANNER_SHOWN=1
  echo "🍋 lemonOS $(lemon version 2>/dev/null)  |  lemon help · lemon ai · lemon boost"
fi
export PS1='\[\e[1;33m\]lemon\[\e[0m\]:\w\$ '
