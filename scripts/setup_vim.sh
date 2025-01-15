#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source utilities using absolute path
source "${SCRIPT_DIR}/utils.sh"

setup_vim() {
    echo "Setting up Vim."
    create_symlink "$DOTFILES_DIR/config/vim" "$CONFIG_DIR/vim"
    mkdir -p "$HOME/.local/state/vim/"{backup,swap,undo}

    # Install vim-plug
    if [ ! -f "$HOME/.local/share/vim/autoload/plug.vim" ]; then
        echo "Installing Vim-Plug..."
        curl -fLo ~/.local/share/vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}
