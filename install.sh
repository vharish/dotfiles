#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# Detect OS
OS="unknown"
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
fi

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to backup and create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Create backup if the file exists and is not a symlink
    if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up $target to $BACKUP_DIR/"
        mv "$target" "$BACKUP_DIR/"
    fi

    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        rm "$target"
    fi

    # Create symlink
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

### VIM Config ###

# Function to setup Vim configuration
setup_vim() {
    echo "Setting up VIM"
    # Setup main vim config directory
    create_symlink "$DOTFILES_DIR/config/vim" "$CONFIG_DIR/vim"

    # Create vim directories for backup, swap, and undo files
    mkdir -p "$HOME/.local/state/vim/"{backup,swap,undo}
}

# Function to install vim plugin manager (optional)
setup_vim_plugins() {
    echo "Setting up VIM Plugins"
    if [ ! -f "$HOME/.local/share/vim/autoload/plug.vim" ]; then
        echo "Installing Vim-Plug..."
        curl -fLo ~/.local/share/vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
}

### Git Config ###

# Function to setup Git configuration
setup_git() {
    echo "Setting up Git"
    # Simple approach - single file
    create_symlink "$DOTFILES_DIR/gitconfig" "$HOME/.gitconfig"

    # Alternatively, for structured approach:
    # create_symlink "$DOTFILES_DIR/config/git" "$CONFIG_DIR/git"
}

### Main setup ###

echo "Setting up dotfiles for $OS..."

# Create necessary directories
mkdir -p "$CONFIG_DIR"

# Setup Vim
setup_vim
setup_vim_plugins
# Setup Git
setup_git

echo "Dotfiles installation complete!"
