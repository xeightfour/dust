#!/bin/bash

set -e

dust="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)" || {
	echo '[ERROR] Failed to determine script directory >=' >&2
	exit 1
}

# Download git-prompt.sh if it doesn't exist
if ! [[ -f ~/git-prompt.sh ]]; then
	echo 'Downloading git-prompt.sh...'
	curl -so ~/git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || {
		echo '[ERROR] Failed to download git-prompt.sh >=' >&2
		exit 1
	}
fi

scripts="$dust/scripts"
if [[ -d $scripts ]]; then
	echo "Making scripts in $scripts executable..."
	chmod +x "$scripts"/* || {
		echo '[ERROR] Failed to make scripts executable >=' >&2
		exit 1
	}
else
	echo "[ERROR] Directory not found: $scripts >=" >&2
	exit 1
fi

echo 'Initialization was successful <:'
