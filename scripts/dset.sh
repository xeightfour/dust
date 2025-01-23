#!/bin/bash

cwd=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") &> /dev/null && pwd)

read -p 'Low or high? [L/h]' stat
if [[ $stat == [Hh] ]]; then
	cp "$cwd"/setup.hi.sh "$cwd"/setup.sh
	"$cwd"/setup.sh
	cp "$cwd"/../.config/picom/picom.hi.conf "$cwd"/../.config/picom/picom.conf
else
	cp "$cwd"/setup.lo.sh "$cwd"/setup.sh
	"$cwd"/setup.sh
	cp "$cwd"/../.config/picom/picom.lo.conf "$cwd"/../.config/picom/picom.conf
fi

echo 'All done <:'
