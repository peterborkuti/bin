#!/bin/bash
. goodmorning.env

DELETE="deploy logs osgi tools work $TOMCAT/lib $TOMCAT/logs $TOMCAT/temp $TOMCAT/webapps $TOMCAT/work"
COPY="deploy osgi tools $TOMCAT/lib $TOMCAT/webapps"

for i in $DELETE; do
    fn="$PORTAL_RUNTIME_DIR/$i"
    globbedfn="${fn/#\~/$HOME}"
    if [ "$globbedfn" != "$HOME" ]; then
	echo $globbedfn
	rm -dr $globbedfn
    else
	echo "Don't set $PORTAL_RUNTIME_DIR to your home! Everything will be deleted next time!"
    fi;
done


for i in $COPY; do
    todir="$PORTAL_RUNTIME_DIR/$i"
    globbedtodir="${todir/#\~/$HOME}"

    fromdir="$BUNDLE_DIR/$i"
    globbedfromdir="${fromdir/#\~/$HOME}"
    cp -r $globbedfromdir $globbedtodir
done