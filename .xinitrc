[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -option grp:alt_shift_toggle -layout us,ir

exec /usr/bin/i3
