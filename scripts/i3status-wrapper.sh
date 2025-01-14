#!/bin/bash

i3status | while :
do
	lang=$(setxkbmap -print | awk -F'+' '/xkb_symbols/ {print $2}')
	read line
	echo "$line" | sed "s/\[{/\[\{\"full_text\":\"$lang\"\},\{/g" || exit 1
done
