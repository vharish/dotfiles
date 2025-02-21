#!/bin/bash

# Get the dotfiles directory (parent of this script)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source utility functions
source "${DOTFILES_DIR}/scripts/utils.sh"

# Source setup scripts
source "${DOTFILES_DIR}/scripts/setup_vim.sh"
source "${DOTFILES_DIR}/scripts/setup_fish.sh"
source "${DOTFILES_DIR}/scripts/setup_git.sh"
source "${DOTFILES_DIR}/scripts/setup_tmux.sh"

# Help function
print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -s, --setup COMPONENT   Setup specific component (vim|fish|git|tmux)"
    echo "  -f, --force            Force setup all components"
    echo "  -h, --help             Print this help message"
    echo ""
    echo "Without any options, performs a dry run listing components to be installed."
}

# Dry run function
dry_run() {
    echo "The following components are available for setup:"
    echo "  - Vim configuration"
    echo "  - Fish shell configuration"
    echo "  - Git configuration"
    echo "  - Tmux configuration"
    echo ""
    echo "To install all components, use: $0 --force"
    echo "To install a specific component, use: $0 --setup COMPONENT"
}

# Parse command line arguments
COMPONENT=""
FORCE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--setup)
            COMPONENT="$2"
            shift 2
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            print_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            print_help
            exit 1
            ;;
    esac
done

# Detect OS
OS=$(detect_os)

# Create necessary directories
mkdir -p "$CONFIG_DIR"

# Execute based on arguments
if [ -n "$COMPONENT" ]; then
    echo "Setting up $COMPONENT for $OS..."
    case $COMPONENT in
        vim)
            setup_vim
            ;;
        fish)
            setup_fish
            ;;
        git)
            setup_git
            ;;
        tmux)
            setup_tmux
            ;;
        *)
            echo "Invalid component: $COMPONENT"
            print_help
            exit 1
            ;;
    esac
    echo "$COMPONENT setup complete!"
elif [ "$FORCE" = true ]; then
    echo "Setting up all components for $OS..."
    setup_vim
    setup_fish
    setup_git
    setup_tmux
    echo "All components setup complete!"
else
    dry_run
fi
