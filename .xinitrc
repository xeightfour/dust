[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -option terminate:ctrl_alt_bksp

exec /usr/bin/i3
