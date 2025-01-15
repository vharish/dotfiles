#!/bin/bash

# Define common variables
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}

# Function to backup and create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"

    if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up $target to $BACKUP_DIR/"
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    fi

    if [ -L "$target" ]; then
        rm "$target"
    fi

    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# Package manager helper
install_package() {
    local package="$1"
    local os=$(detect_os)

    echo "Installing $package..."
    if [ "$os" = "macos" ]; then
        brew install "$package"
    elif [ "$os" = "linux" ]; then
        sudo apt-get update && sudo apt-get install -y "$package"
    fi
}
