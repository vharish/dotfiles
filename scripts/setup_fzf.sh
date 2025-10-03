#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/utils.sh"

# --- Main Functions ---

setup_fzf() {
    echo "Setting up fzf (fuzzy finder)..."

    if [ -d "$HOME/.fzf" ]; then
        echo "fzf is already installed at ~/.fzf."
    else
        echo "Installing fzf from source..."
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    fi

    # Run the installer, but prevent it from modifying shell configuration files.
    # Your dotfiles will manage the shell integration.
    echo "Running fzf installer to get the latest binary..."
    ~/.fzf/install --bin

    echo "fzf setup complete!"
    echo "Your Fish and Bash config files will automatically source fzf."
}

uninstall_fzf() {
    echo "Uninstalling fzf..."
    if [ -f "$HOME/.fzf/uninstall" ]; then
        # Run the official non-interactive uninstall script
        ~/.fzf/uninstall --force
        rm -rf "$HOME/.fzf" # Remove the directory as well
        echo "fzf has been uninstalled."
    else
        echo "fzf installation not found at ~/.fzf."
    fi

    # Note: This script does not automatically clean up your rc files
    # because they are part of your dotfiles repo.
}


# --- Script Execution Logic ---

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ "$1" == "--uninstall" ]]; then
        uninstall_fzf
    else
        setup_fzf
    fi
fi
