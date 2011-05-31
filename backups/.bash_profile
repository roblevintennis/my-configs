# To debug login, uncomment:
#set -xv
# Probably don't need following: 
#exec > /tmp/sh.out.$$ 2>&1

. ~/git-completion.bash
. /usr/local/bin/virtualenvwrapper.sh
alias l="ls -hal"
#alias ff="find . -name '*\!{*}*' -ls"
alias vim=/Applications/mvim 
#alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'

# Excuberant ctags (default ctags preinstalled is int /usr/bin/ctags
alias ctags='/usr/local/bin/ctags' 

alias john=/Applications/john-1.7.6/run/john
alias unshadow=/Applications/john-1.7.6/run/unshadow
alias hping="sudo /opt/local/sbin/hping2"
alias phantomjs=/Applications/phantomjs.app/Contents/MacOS/phantomjs

# Deals with some weirdess where mysql_config can't be found
export PATH=/usr/local/mysql/bin:$PATH

export PATH=~/bin:$PATH
export PATH=~/bin/wireshark_cli:$PATH
export PATH=$HOME/bin/node/bin:$PATH #nodeje

export EDITOR=/Applications/mvim

export JSTESTDRIVER_HOME=~/bin

set -o vi        # Use vi like editing
set -o ignoreeof # Cntr-D twice will not logout of shell
set -o noclobber # don't overrite on > redirection
#echo $SHELLOPTS

##
# Your previous /Users/roblevin/.bash_profile file was backed up as /Users/roblevin/.bash_profile.macports-saved_2010-12-08_at_22:18:35
##

# MacPorts Installer addition on 2010-12-08_at_22:18:35: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Hack 10 from Linux Server Hack pg. 20
# export PS1=`echo -ne "\033[0;32m\h:\033[0;36m\W\033[0;34m\$\033[0;37m "`
# export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
# export PROMPT_COMMAND=’echo -ne “\033]0;${USER}@${HOSTNAME%%.*}\007″‘
# UPTs: You also can add color to your prompt! For instance, make the previous 
# prompt for bash using bright red (1;31) on a blue background (44):
#PS1='\[\e[1;31;44m\]root\[\e[0m\]@\H# '

export PS1='\h:\W \u\$ '

# For reading custom Man pages in ~/man
myman( ) { (man -M ~/man "$1" | less); }

# UPT function for output like: 04/23/11 07:31:12 ~/man/cat1
function do_prompt {
   date=`date '+%D %T'`
   dir=`echo $PWD | sed "s@$HOME@~@"`
   echo "$date $dir"
   unset date dir
}
function verbose {
   export PS1='\h:\w\n\A:\u\n$ '
}
[[ -s "/Users/roblevin/.rvm/scripts/rvm" ]] && source "/Users/roblevin/.rvm/scripts/rvm"
