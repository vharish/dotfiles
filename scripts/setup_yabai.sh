#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/utils.sh"

setup_yabai() {
    # Create local directories if they don't exist
    mkdir -p ~/.local/bin ~/.local/man

    # Install yabai using official install script
    if ! command -v yabai &> /dev/null; then
        echo "Installing yabai from GitHub..."
        curl -L https://raw.githubusercontent.com/koekeishiya/yabai/master/scripts/install.sh | sh /dev/stdin ~/.local/bin ~/.local/man
    fi

    # Install skhd from GitHub
    if ! command -v skhd &> /dev/null; then
        echo "Installing skhd..."
        brew install koekeishiya/formulae/skhd
    fi

    # Create config directories
    create_symlink "$DOTFILES_DIR/config/yabai/yabairc" "$HOME/.config/yabai/yabairc"
    create_symlink "$DOTFILES_DIR/config/skhd/skhdrc" "$HOME/.config/skhd/skhdrc"

    # Ensure configs are executable
    chmod +x "$HOME/.config/yabai/yabairc"

    echo "Note: You need to enable accessibility permissions for yabai and skhd in System Preferences > Security & Privacy > Privacy > Accessibility"
}

# Run setup only if the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_yabai
fi
