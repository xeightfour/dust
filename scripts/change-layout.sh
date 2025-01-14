#!/bin/bash

lang=$(setxkbmap -print | awk -F'+' '/xkb_symbols/ {print $2}')
if [[ $lang == ir ]]; then
	setxkbmap -layout us
else
	setxkbmap -layout ir
fi
