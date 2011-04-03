#!/bin/bash
PROJECT=$1

if [ -z "$PROJECT" ] ; then
    echo "usage: $0 <PROJECTNAME>"
    echo "Suggestion: use one of"
    mpListProjects
else

    SETUPFILE="`mpFindSetupfile $PROJECT`"

    if [ ! -f "$SETUPFILE" ] ; then
	echo "Illegal Project Name $PROJECT: could not find setup file $SETUPFILE"
    else
        . "$SETUPFILE"
        cd "$CSW"
    fi

fi
