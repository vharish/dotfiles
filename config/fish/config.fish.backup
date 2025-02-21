# ~/dotfiles/config/fish/config.fish

# Initialize Fisher if installed
if not functions -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
end

# Load all files in conf.d directory
for file in ~/.config/fish/conf.d/*.fish
    source $file
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
