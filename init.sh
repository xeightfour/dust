#!/bin/bash

function bounce {
	echo '[ERROR] Something went wrong ):' && exit 1
}

if ! [[ -f ~/git-prompt.sh ]]; then
	echo 'Receiving git-prompt.sh...'
	curl -so ~/git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || bounce
fi

dust=$(cd -- $(dirname -- "${BASH_SOURCE[0]}") &> /dev/null && pwd)
chmod +x $dust/scripts/*
$dust/scripts/dset || bounce

echo 'All done <:'
