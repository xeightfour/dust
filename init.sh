#!/bin/bash

# Function to handle errors and exit with a message
function bounce {
    echo '[ERROR] Something went wrong ):'
    exit 1
}

# Check if git-prompt.sh exists, if not, download it
if ! [[ -f ~/git-prompt.sh ]]; then
    echo 'Receiving git-prompt.sh...'
    curl -so ~/git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh' || bounce
fi

# Get the directory of the current script
dust=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd) || bounce

# Ensure the scripts directory exists and contains executable scripts
if [[ -d "$dust/scripts" ]]; then
    echo "Making scripts in $dust/scripts executable..."
    chmod +x "$dust/scripts"/* || bounce
else
    echo "[ERROR] Scripts directory not found at $dust/scripts"
    bounce
fi

# Run the dset script
echo 'Running dset script...'
"$dust/scripts/dset" || bounce

echo 'Initialization was successful!'
