#!/bin/bash

set -e

bounce() {
	echo "$1" >&2
	exit 1
}

dust="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

scripts="$dust/scripts"
if [[ -d "$scripts" ]]; then
	echo "Making scripts in $scripts executable..."
	chmod +x "$scripts"/* || bounce 'Failed to make scripts executable >:'
else
	bounce "Directory not found: $scripts >:"
fi

echo 'Initialization was successful <:'
