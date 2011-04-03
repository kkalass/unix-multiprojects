MP_SETUPFILE_BASENAME=${MP_SETUPFILE_BASENAME=setup-dev-env.sh}

function mpListProjects {
    find "$MP_PROJECTS_ROOT/"  -maxdepth 2 -mindepth 1 -name "$MP_SETUPFILE_BASENAME" | sed -n "s#$MP_PROJECTS_ROOT/\([^/]*\)/$MP_SETUPFILE_BASENAME#\t\1#gp"
}

function mpFindSetupfile {
    local PROJECT=$1
    local FILE="$MP_PROJECTS_ROOT/$PROJECT/$MP_SETUPFILE_BASENAME"
    echo $FILE
}

function mpFindProjectHome {
    local PROJECT=$1
    local DIR="$MP_PROJECTS_ROOT/$PROJECT"
    echo $DIR
}

function mpSetDefault {

    local PROJECT=$1

    if [ -z "$PROJECT" ] ; then
        echo "usage: mpSetDefault <PROJECTNAME>"
        echo "Suggestion: use one of"
        mpListProjects
        return 1
    fi


    local SETUPFILE="`mpFindSetupfile $PROJECT`"

    if [ ! -f "$SETUPFILE" ] ; then
        echo "Illegal Project Name $PROJECT: could not find setup file $SETUPFILE"
        return 1
    fi

    rm -f "$MP_DEFAULT_PROJECT_LINK"
    ln -s "$SETUPFILE" "$MP_DEFAULT_PROJECT_LINK"
}

if [ -z "$MP_PROJECTS_ROOT" ] ; then
	echo "Please specify your projects root directory by setting: MP_PROJECTS_ROOT"
else
	MP_DEFAULT_PROJECT_LINK="$HOME/.mpDefaultProject"
	if [ -f "$MP_DEFAULT_PROJECT_LINK" ] ; then
		. "$MP_DEFAULT_PROJECT_LINK"
	fi
	for p in `mpListProjects` ; do
		alias $p=". \"$MP_BIN/mp-switch-current-project.sh\" $p"
	done
fi
