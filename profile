# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set EDITOR to vim
export EDITOR='vim'
#set TERM
#if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#        export TERM='xterm-256color'
#else
#        export TERM='xterm-color'
#fi

# Setting for the new UTF-8 terminal support in Lion
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8
alias devdb='mysql --defaults-file=~/.config/sql/mysql-dev.conf -A'
alias ckall="./CodeSniffer/scripts/phpcs '--ignore=Resources/public,Symfony/src/Stockopedia/Common/AppBundle/Resources/*' --standard=PSR2 -n Symfony/src/Stockopedia/ArchiveBundle Symfony/src/Stockopedia/BatchBundle Symfony/src/Stockopedia/BlogSyndicationBundle Symfony/src/Stockopedia/Common Symfony/src/Stockopedia/DdlBundle Symfony/src/Stockopedia/DemoBundle Symfony/src/Stockopedia/FtpBundle Symfony/src/Stockopedia/MonitorBundle Symfony/src/Stockopedia/NewsBundle Symfony/src/Stockopedia/PdfBundle Symfony/src/Stockopedia/QuotesBundle Symfony/src/Stockopedia/ScreenBundle Symfony/src/Stockopedia/SearchBundle Symfony/src/Stockopedia/Security Symfony/src/Stockopedia/SiteBundle Symfony/src/Stockopedia/SystemBundle Symfony/src/Stockopedia/TechnicalsBundle"
alias ckcode="./CodeSniffer/scripts/phpcs '--ignore=Resources/public,Symfony/src/Stockopedia/Common/AppBundle/Resources/*' --standard=PSR2 -n "
alias gdc='git diff --cached'
