#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source utilities using absolute path
source "${SCRIPT_DIR}/utils.sh"

setup_git() {
    echo "Setting up Git."
    create_symlink "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"
}
