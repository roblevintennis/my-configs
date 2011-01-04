# base-files version 3.9-3

# To pick up the latest recommended .bash_profile content,
# look in /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# ~/.bash_profile: executed by bash for login shells.

# source the system wide bashrc if it exists
if [ -e /etc/bash.bashrc ] ; then
  source /etc/bash.bashrc
fi

# source the users bashrc if it exists
if [ -e "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
#   PATH=${HOME}/bin:${PATH}
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH=${HOME}/man:${MANPATH}
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH=${HOME}/info:${INFOPATH}
# fi

export JSTESTDRIVER_HOME=~/bin

alias h="pushd /cygdrive/h;"
alias vi=vim
alias dir='ls -lav --color=auto'
alias l='ls -hal --color=auto'
alias c=''

# set colors and prompt
export PS1="\[\e]2;rob:\w\007\e[1;36m\][\[\e[1;35m\]\w\[\e[1;36m\]] \u $ \[\e[1;33m\]"

set -o vi
export HISTSIZE=1000
export HISTFILE=~/.history
export HISTFILESIZE=1000
export EDITOR=vi

# winshit
export CYGWIN="ntsec"
umask 022
