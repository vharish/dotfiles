#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/utils.sh"

setup_bash() {
    echo "Setting up Bash configuration..."

    # Create bash config directories and files
    mkdir -p "$HOME/.bash"

    # Create .bashrc
    create_symlink "$DOTFILES_DIR/config/bash/bashrc" "$HOME/.bashrc"

    # Create .bash_profile
    create_symlink "$DOTFILES_DIR/config/bash/bash_profile" "$HOME/.bash_profile"

    # Create other bash configs
    create_symlink "$DOTFILES_DIR/config/bash/bash_aliases" "$HOME/.bash_aliases"
    create_symlink "$DOTFILES_DIR/config/bash/bash_functions" "$HOME/.bash_functions"

    echo "Bash setup complete!"
}

# Run setup if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_bash
fi
