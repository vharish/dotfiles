#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source utilities using absolute path
source "${SCRIPT_DIR}/utils.sh"

setup_fish() {
    echo "Setting up Fish."
    # Install Fish if not present
    if ! command -v fish &> /dev/null; then
        install_package "fish"
    fi

    # Create fish config directories
    create_symlink "$DOTFILES_DIR/config/fish" "$CONFIG_DIR/fish"

    # Install Fisher
    if ! fish -c "functions -q fisher" &> /dev/null; then
        echo "Installing Fisher..."
        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

        # Install Hydro theme
        fish -c "fisher install jorgebucaran/hydro"
    fi

    # Install plugins from fish_plugins file
    echo "Installing Fisher plugins..."
    fish -c "fisher update"

    # Set as default shell if not already
    if [[ "$SHELL" != *"fish"* ]]; then
        echo "Setting Fish as default shell..."
        chsh -s $(which fish)
    fi
}
