#!/bin/bash
# setup_ghostty.sh

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SCRIPT_DIR}/utils.sh"

setup_ghostty() {
    echo "Setting up Ghostty configuration..."
    mkdir -p "$HOME/.config/ghostty"
    
    # Find fish path
    FISH_PATH=$(which fish)
    
    # Create configuration file
    cat > "$HOME/.config/ghostty/config" << EOF
# Auto-generated Ghostty configuration
shell = $FISH_PATH

# Base appearance
background = #232425
foreground = #ffffff
font-family = "Source Code Pro"
font-size = 14
pad = 12

# Terminal features
clipboard-read = allow
clipboard-write = allow
confirm-close-surface = false
mouse-hide-while-typing = true

# Performance
cursor-blink = false
unfocused-split-opacity = 0.95

# Interface
tab-position = bottom
window-padding-x = 6
window-padding-y = 6
EOF

    echo "Ghostty configuration complete!"
}

# Run setup if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_ghostty
fi
