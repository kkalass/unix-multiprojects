#
# Example of what you could have in your ~/.bashrc
#

#
# Shell prompt that includes git status information
#
export PS1='\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[31m\]$(__git_ps1 " (%s)")\[\033[01;34m\]$\[\033[00m\] '

#
# My own settings for the multiprojects setup
#
MP_PROJECTS_ROOT="/media/Daten Klas/Daten/2011/Programmierprojekte"
MP_BIN="/media/Daten Klas/Daten/2011/Programmierprojekte/multiprojects/bin"

# Initialize the multiprojects setup, will source the default project if that was set
. $MP_BIN/mp-setup.sh

