#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/utils.sh"

setup_fzf() {
    echo "Setting up fzf (fuzzy finder)..."

    # Install the fzf package using the helper function
    if ! command -v fzf &> /dev/null; then
        install_package "fzf"
    fi

    # The fzf package often comes with an install script for shell bindings.
    # We run it non-interactively to set up the necessary files like ~/.fzf.bash
    # The --all flag updates configs for all supported shells without prompting.
    echo "Configuring shell integrations for fzf..."
    if [ -f /usr/bin/fzf ]; then # Path for Linux apt
        /usr/bin/fzf --all
    elif [ -f /opt/homebrew/bin/fzf ]; then # Path for macOS brew
         /opt/homebrew/opt/fzf/install --all
    else
        echo "fzf executable not found in standard paths. Shell integration may need manual setup."
    fi

    echo "fzf setup complete!"
}

# Run setup if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_fzf
fi
