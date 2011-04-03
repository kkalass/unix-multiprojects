MP_SETUPFILE_BASENAME=${MP_SETUPFILE_BASENAME=setup-dev-env.sh}

#
# Erzeugt ein Array-Konstruktor mit allen Projekten
#
function mpListProjects {
    echo "("
    for root in "${MP_PROJECTS_ROOT[@]}" ; do
        find "$root/"  -maxdepth 2 -mindepth 1 -name "$MP_SETUPFILE_BASENAME" | sed -n "s#$root/\([^/]*\)/$MP_SETUPFILE_BASENAME#\t\"\1\"#gp"
    done
    echo ")"
}

#
# Listet alle Verzeichnisse auf, die unterhalb eines der 
# ProjectRoots sind
#
function mpListProjectCandidates {
    echo "("
    for root in "${MP_PROJECTS_ROOT[@]}" ; do
        find "$root/"  -maxdepth 1 -mindepth 1 -type d | sed -n "s#$root/\([^/]*\)#\t\"\1\"#gp"
    done
    echo ")"

}

function mpFindSetupfile {
    local PROJECT=$1
    for root in "${MP_PROJECTS_ROOT[@]}" ; do
       local FILE="$root/$PROJECT/$MP_SETUPFILE_BASENAME"
       if [ -f "$FILE" ] ; then
           echo $FILE
           return
       fi
    done
}

function mpFindProjectHome {
    local PROJECT=$1
    for root in "${MP_PROJECTS_ROOT[@]}" ; do
       local DIR="$root/$PROJECT"
       if [ -d "$DIR" ] ; then
           echo $DIR
           return
       fi
    done
}

function mpSetDefault {

    local PROJECT=$1

    if [ -z "$PROJECT" ] ; then
        echo "usage: mpSetDefault <PROJECTNAME>"
        echo "Suggestion: use one of"
        local -a projects=`mpListProjects`
	echo "${projects[$@]}"
        return 1
    fi


    local SETUPFILE="`mpFindSetupfile "$PROJECT"`"

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
        declare -a projects=`mpListProjects`
	echo -n "Available Projects: "
	for p in "${projects[@]}" ; do
		aliasname="`echo $p | sed "s/[ -]//g" `"
		echo -n "'$aliasname' "
		alias $aliasname=". \"$MP_BIN/mp-switch-current-project.sh\" \"$p\""
	done
        echo ""
fi
