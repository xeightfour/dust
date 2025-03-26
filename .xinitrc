[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option grp:alt_shift_toggle -layout us,ir

polkit="/usr/lib/mate-polkit/polkit-mate-authentication-agent-1"
[[ -x "$polkit" ]] && "$polkit" &

exec /usr/bin/i3
