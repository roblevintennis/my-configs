#!/bin/bash

#############################################
# github_backup.sh - Copies over local files 
# to local github repository for later push. 
#############################################

# My Configs and SnipMate Local Repos
MYCONFIGS_REPO=~/github/my-configs/backups
SNIPMATE_REPO=~/.vim/New\ Stuff/snipmate/MY_FORK/vim-snipmate

##################
# SnipMate Backup
##################

JS_SNIPPET=~/.vim/snippets/javascript.snippets
echo "Copying: ${JS_SNIPPET}"
echo "To: ${SNIPMATE_REPO}/snippets"
cp "${JS_SNIPPET}" "${SNIPMATE_REPO}/snippets"

JS2_SNIPPET=~/.vim/snippets/javascript/javascript_patterns.snippets
echo "Copying: ${JS2_SNIPPET}"
echo "To: ${SNIPMATE_REPO}/snippets/javascript"
cp "${JS2_SNIPPET}" "${SNIPMATE_REPO}/snippets/javascript"

SM_PLUGIN=~/.vim/plugin/snipMate.vim
echo "Copying: ${SM_PLUGIN}"
echo "To: ${SNIPMATE_REPO}/plugin"
cp "${SM_PLUGIN}" "${SNIPMATE_REPO}/plugin"
#snipMateFilesArray=($JS_SNIPPET $JS2_SNIPPET $SM_PLUGIN)


#####################
# Local Config Files
#####################

# Local config files to backup
LOC_BASHPROFILE=~/.bash_profile 
LOC_VIMRC=~/.vimrc
LOC_COMMENT=~/.vim/plugin/comment.vim
localConfigsArray=($LOC_COMMENT $LOC_VIMRC $LOC_BASHPROFILE)

#############################
# Copy over the local configs 
#############################

tLen=${#localConfigsArray[@]} # get length of an array

for (( i=0; i<${tLen}; i++ )); do
  if [ -f ${localConfigsArray[$i]} ]; then
    echo "Copying ${localConfigsArray[$i]}"
    echo "To: ${MYCONFIGS_REPO}"
    cp ${localConfigsArray[$i]} "${MYCONFIGS_REPO}"
  else
    echo "Array element ${localConfigsArray[$i]} NOT a file..."
  fi
done

#
# Clean exit
exit 0

