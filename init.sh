#!/bin/bash

bounce() {
	echo -e "$1 \e[31m):\e[0m"
	exit 1
}

dust="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

scripts="$dust/scripts"
if [[ -d "$scripts" ]]; then
	chmod +x "$scripts"/* || bounce "Whoops, couldn’t make those scripts runnable"
else
	bounce "Oops, $scripts is playing hide and seek"
fi

echo "All set, ready to roll."
