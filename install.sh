#!/bin/bash

# Get the dotfiles directory (parent of this script)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source utility functions
source "${DOTFILES_DIR}/scripts/utils.sh"

# Source setup scripts
source "${DOTFILES_DIR}/scripts/setup_bash.sh"
source "${DOTFILES_DIR}/scripts/setup_vim.sh"
source "${DOTFILES_DIR}/scripts/setup_fish.sh"
source "${DOTFILES_DIR}/scripts/setup_git.sh"
source "${DOTFILES_DIR}/scripts/setup_tmux.sh"
source "${DOTFILES_DIR}/scripts/setup_ghostty.sh"
source "${DOTFILES_DIR}/scripts/setup_yabai.sh"

# --- Help Function ---
print_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "This script sets up your dotfiles by creating symlinks and installing necessary packages."
    echo ""
    echo "Options:"
    echo "  -s, --setup COMPONENT   Set up a specific component. See the list of available"
    echo "                          components below."
    echo "  -f, --force             Force setup of all components that are compatible with your"
    echo "                          operating system."
    echo "  -h, --help              Display this help message and exit."
    echo ""
    echo "Available Components:"
    echo "  bash, vim, fish, git, tmux, ghostty, yabai"
    echo ""
    echo "Examples:"
    echo "  ./install.sh                # Perform a dry run to see what would be installed."
    echo "  ./install.sh --force        # Install all compatible components for your OS."
    echo "  ./install.sh --setup vim    # Install only the Vim configuration."
    echo "  ./install.sh -s fish        # Install only the Fish shell configuration."
}

# --- Dry Run Function ---
dry_run() {
    OS=$(detect_os)
    echo "Detected OS: $OS"
    echo "This is a dry run. No changes will be made."
    echo "The following components are available for setup:"
    echo "  - Bash"
    echo "  - Vim"
    echo "  - Fish"
    echo "  - Git"
    echo "  - Tmux"

    if [[ "$OS" == "macos" ]]; then
        echo "  - Ghostty"
        echo "  - Yabai (macOS only)"
    elif [[ "$OS" == "linux" ]]; then
        echo "  - Ghostty"
    fi

    if [[ "$OS" == "wsl" ]]; then
       echo ""
       echo "Note: Ghostty and Yabai setups are skipped on WSL."
       echo "Please configure your Windows terminal emulator manually."
    fi

    echo ""
    echo "To install all compatible components, run: $0 --force"
    echo "To install a specific one, run: $0 --setup <component_name>"
}

# --- Main Logic ---

# Check if no arguments are provided to perform a dry run
if [ $# -eq 0 ]; then
    dry_run
    exit 0
fi

# Initialize variables
COMPONENT=""
FORCE=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--setup)
            if [ -n "$2" ]; then
                COMPONENT="$2"
                shift 2
            else
                echo "Error: --setup option requires a component name."
                print_help
                exit 1
            fi
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

# --- Execution Logic ---

OS=$(detect_os)

# If a specific component is requested, set it up
if [ -n "$COMPONENT" ]; then
    echo "Setting up $COMPONENT for $OS..."
    case $COMPONENT in
        bash|vim|fish|git|tmux)
            "setup_$COMPONENT"
            ;;
        ghostty)
            if [[ "$OS" == "wsl" ]]; then
                echo "Skipping Ghostty setup on WSL. Please configure your Windows terminal manually."
            else
                setup_ghostty
            fi
            ;;
        yabai)
            if [[ "$OS" == "macos" ]]; then
                setup_yabai
            else
                echo "Yabai is only for macOS. Skipping setup on $OS."
            fi
            ;;
        *)
            echo "Invalid component: $COMPONENT"
            print_help
            exit 1
            ;;
    esac
    echo "$COMPONENT setup complete!"

# If the force flag is used, set up all compatible components
elif [ "$FORCE" = true ]; then
    echo "Setting up all compatible components for $OS..."
    setup_bash
    setup_vim
    setup_fish
    setup_git
    setup_tmux

    if [[ "$OS" == "wsl" ]]; then
        echo "Skipping Ghostty and Yabai setup on WSL."
    else
        setup_ghostty
        if [[ "$OS" == "macos" ]]; then
            setup_yabai
        fi
    fi
    echo "All compatible components setup complete!"
fi
