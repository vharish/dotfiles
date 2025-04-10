# ~/dotfiles/config/fish/config.fish
# /opt/homebrew/bin/brew shellenv | source

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/harishimmadi/google-cloud-sdk/path.fish.inc' ]; . '/Users/harishimmadi/google-cloud-sdk/path.fish.inc'; end
