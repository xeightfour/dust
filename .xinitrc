[[ -f ~/.Xresources ]] && xrdb -load ~/.Xresources

setxkbmap -option terminate:ctrl_alt_bksp
setxkbmap -layout us,ir -option grp:alt_shift_toggle

exec /usr/bin/i3
