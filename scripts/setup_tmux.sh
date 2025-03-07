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

    # Create tmux directories
    mkdir -p "$CONFIG_DIR/tmux"
    mkdir -p "$HOME/.local/share/tmux/resurrect"

    # Link configuration
    create_symlink "$DOTFILES_DIR/config/tmux/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"

    # Install plugins automatically
    echo "Installing tmux plugins..."
    tmux start-server
    tmux new-session -d
    "$TPM_DIR/scripts/install_plugins.sh" > /dev/null 2>&1
    tmux kill-server

    echo "Tmux setup complete!"
}

# Run setup if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_tmux
fi
