# ~/dotfiles/config/fish/conf.d/env.fish

# Set environment variables
set -gx EDITOR vim
set -gx VISUAL vim
set -x LANG en_US.UTF-8

# Add fzf to PATH if it exists
if test -d "$HOME/.fzf/bin"
    set -gx PATH $HOME/.fzf/bin $PATH
end

# Add user's local bin to PATH
set -gx PATH $HOME/.local/bin $PATH

# OS specific settings
switch (uname)
    case Darwin
        # macOS specific environment variables
        set -gx PATH /opt/homebrew/bin $PATH
    case Linux
        # Linux specific environment variables
end
