#!/bin/bash

# Get the dotfiles directory (parent of this script)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source utility functions
source "${DOTFILES_DIR}/scripts/utils.sh"

# Source setup scripts
source "${DOTFILES_DIR}/scripts/setup_vim.sh"
source "${DOTFILES_DIR}/scripts/setup_fish.sh"
source "${DOTFILES_DIR}/scripts/setup_git.sh"

# Detect OS
OS=$(detect_os)
echo "Setting up dotfiles for $OS..."

# Create necessary directories
mkdir -p "$CONFIG_DIR"

# Run setups
setup_vim
setup_fish
setup_git

echo "Dotfiles installation complete!"
