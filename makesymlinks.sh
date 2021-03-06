#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc gitconfig vim zshrc tmux.conf my_aliases sh_aliases profile"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

file="$HOME/bin/battery"
if [ -f "$file" ]
then
    echo 'Setting up tmux battery status..'
    curl -OL https://raw.github.com/richo/battery/master/bin/battery
    mv battery ~/bin/battery
    chmod +x ~/bin/battery
    echo 'Tmux battery setup done'
fi

echo 'Setup finished'
