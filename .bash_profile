export ANT_HOME=/usr/share/ant
M2_HOME=/usr/local/maven
export M2=$M2_HOME/bin.
export JAVA_HOME=/Library/Java/Home  
export M2_REPO=/Users/roblevin/.m2/repository
MYSQL=/usr/local/mysql

# DERBY DB:
# file:///Developer/Examples/JavaWebObjects/Databases/db-derby-10.3.2.1-bin/docs/html/getstart/index.html
# java -jar $DERBY_HOME/lib/derbyrun.jar server start | shutdown
# java -jar $DERBY_HOME/lib/derbyrun.jar sysinfo | ij | etc.,etc.
export DERBY_HOME=/Developer/Examples/JavaWebObjects/Databases/db-derby-10.3.2.1-bin

# HSQLDB
export HSQLDB_HOME=/Users/roblevin/Desktop/POJOS/hsqldb

# Tomcat Server
CATALINA_BASE=/Users/roblevin/Desktop/POJOS/Tutorials/lulu/Tomcat-6.0.18
CATALINA_HOME=/Users/roblevin/Desktop/POJOS/Tutorials/lulu/Tomcat-6.0.18
export CATALINA_HOME
export CATALINA_BASE

# /usr/local/bin finds my progs first (especially for ctags)
export PATH="$M2:$M2_REPO:$JAVA_HOME/bin:$MYSQL/bin:$DERBY_HOME/bin:/usr/local/bin:$PATH"
#export MAVEN_OPTS=-Xms256m -Xmx512m # This environment variable can be used to supply extra options to Maven.

export ECLIPSE_HOME=/Applications/eclipse

# ALIASES
source ~/.aliases

echo "Shell PID $$ started at `date`" >> ~/login.log

case "$TERM" in
    vt100)
        echo "vt100 terminal"
        #...do commands for vt100
        ;;
    xterm-color)        
        # PROMPT (should probably move this to .bashrc!)
        echo "You are running an xterm-color terminal. Setting PS1 (prompt) now..."
        export PS1="[\t][\u@\h:\w][\s:\V]\$ "
        ;;
    xterm)
            # PROMPT (should probably move this to .bashrc!)
        echo "You are running an xterm terminal. Setting PS1 (prompt) now..."
        export PS1="[\t][\u@\h:\w][\s:\V]\$ "
        ;;
    *)
        #...do commands for other terminals
        echo "Oops, you're running some terminal other than xterm or vt100."
        ;;
esac

function tree {
find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

function set_window_and_tab_title
{
    local title="$1"
    if [[ -z "$title" ]]; then
        title="root"
    fi

    local tmpdir=~/Library/Caches/${FUNCNAME}_temp
    local cmdfile="$tmpdir/$title"

    # Set window title
    echo -n -e "\e]0;${title}\a"

    # Set tab title
    if [[ -n ${CURRENT_TAB_TITLE_PID:+1} ]]; then
        kill $CURRENT_TAB_TITLE_PID
    fi
    mkdir -p $tmpdir
    ln /bin/sleep "$cmdfile"
    "$cmdfile" 10 &
    CURRENT_TAB_TITLE_PID=$(jobs -x echo %+)
    disown %+
    kill -STOP $CURRENT_TAB_TITLE_PID
    command rm -f "$cmdfile"
}

PROMPT_COMMAND='set_window_and_tab_title "${PWD##*/}"'

##
# Your previous /Users/roblevin/.bash_profile file was backed up as /Users/roblevin/.bash_profile.macports-saved_2009-07-06_at_11:51:23
##

# MacPorts Installer addition on 2009-07-06_at_11:51:23: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2009-07-06_at_11:51:23: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.


##
# Your previous /Users/roblevin/.bash_profile file was backed up as /Users/roblevin/.bash_profile.macports-saved_2009-08-02_at_17:40:18
##

# MacPorts Installer addition on 2009-08-02_at_17:40:18: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2009-08-02_at_17:40:18: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.



if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi


##
# Your previous /Users/roblevin/.bash_profile file was backed up as /Users/roblevin/.bash_profile.macports-saved_2009-09-26_at_02:41:41
##

# MacPorts Installer addition on 2009-09-26_at_02:41:41: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2009-09-26_at_02:41:41: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.

