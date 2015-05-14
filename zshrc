# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vagrant/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Antigen
source ~/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle command-not-found
antigen bundle djui/alias-tips
antigen bundle history
antigen bundle tmux
antigen bundle rupa/z

# Completions
antigen bundle zsh-users/zsh-completions src

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell antigen that you're done.
antigen apply

# Add sh aliases.
if [ -f ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

# Add custom aliases.
if [ -f ~/.my_aliases ]; then
    source ~/.my_aliases
fi

# Add profile settings
if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Add profile settings
if [ -f ~/.bin/tmuxinator.zsh ]; then
    source ~/.bin/tmuxinator.zsh
fi

# export TERM="xterm-256color"

setopt RM_STAR_WAIT

setopt interactivecomments

setopt CORRECT
