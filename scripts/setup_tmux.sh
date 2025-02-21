#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/utils.sh"

setup_tmux() {
    echo "Setting up tmux configuration..."

    # Install tmux if not present
    if ! command -v tmux &> /dev/null; then
        install_package "tmux"
    fi

    # Install TPM
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        echo "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    fi

    # Create tmux config directory
    mkdir -p "$CONFIG_DIR/tmux"

    # Link configuration
    create_symlink "$DOTFILES_DIR/config/tmux/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"

    # Install plugins automatically
    echo "Installing tmux plugins..."
    "$TPM_DIR/bin/install_plugins"

    echo "Tmux setup complete!"
}

# Run setup if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_tmux
fi
