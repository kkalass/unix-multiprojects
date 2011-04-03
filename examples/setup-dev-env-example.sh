#!/bin/bash

#
# project specific configuration 
#
PROJECT_HOME="`mpFindProjectHome someprojectname`"
PROJECT_DEV_BASE="$PROJECT_HOME/src/work"
PROJECT_TOMCAT="$PROJECT_HOME/app/tomcat/"

# conventions, you should define those for every project
export CSW="$PROJECT_HOME/src/work"
alias cdw-someproj="cd \"$PROJECT_DEV_BASE\""
alias cdw=cdw-someproj

# further project specific variables and aliases
alias cd-someproj="cd $PROJECT_HOME"

alias cdtom="cd $PROJECT_TOMCAT"
alias eclipse-someproj="export GDK_NATIVE_WINDOWS=true; $PROJECT_HOME/local/opt/eclipse-helios/eclipse -vm /home/klas/Lokal/java/jdk/bin  -showlocation -data $PROJECT_HOME/eclipse-workspace -vmargs  -Xms768M -Xmx768M -XX:MaxPermSize=512m -Duser.name=\"Klas Kalass (klas.kalass@freiheit.com)\"   > /dev/null 2>&1 </dev/zero &"

alias catalina-someproj="export CATALINA_OPTS=\"-Dfile.encoding=ISO-8859-1 -Djava.awt.headless=true\";$PROJECT_TOMCAT/bin/catalina.sh"

alias solr-someproj="export CATALINA_OPTS=\"-Dfile.encoding=ISO-8859-1 -Djava.awt.headless=true\";$PROJECT_HOME/app/solr/bin/catalina.sh"

export PATH="$PROJECT_HOME/bin:$PATH"
export ANT_OPTS="$ANT_OPTS -Xmx384M"
export JAVA_OPTS="$JAVA_OPTS  -server -Xss256k -Xms512M -Xmx768M -XX:MaxPermSize=512m"
