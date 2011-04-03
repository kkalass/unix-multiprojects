#!/bin/bash
PROJECT=$1

if [ -z "$PROJECT" ] ; then
    echo "Illegal usage, supply a valid project name"
else

    SETUPFILE="`mpFindSetupfile "$PROJECT"`"

    if [ ! -f "$SETUPFILE" ] ; then
	echo "Illegal Project Name $PROJECT: could not find setup file $SETUPFILE"
    else
        . "$SETUPFILE"
        cd "$CSW"
    fi

fi
