#!/bin/sh

set -e
set -u

bounce() {
	printf "${1:-Broken for a reason} \e[31m):\e[0m\n"
	exit 1
}

dust="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)"
scripts="$dust/scripts"

if [ -d "$scripts" ]; then
	chmod +x "$scripts"/* ||
		bounce "Whoops, couldn’t make those scripts runnable"
else
	bounce "Oops, $scripts is playing hide and seek"
fi

echo "Running dset script..."
"$scripts/dset"

echo "All set, ready to roll."
