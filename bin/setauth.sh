#!/usr/bin/env bash

authtype=$1
adwarn="Make sure you have your AD server turned on!"

if [ "$authtype" == "" ]
then
        echo "No auth option given. Assuming NTLM."
        authtype="ntlm"
fi

authannounce="Setting auth to $authtype"

globsettings="alfresco-global.properties"
settingsfile="/alfresco/settings/alfresco-global.properties.$authtype"
sharedfile="/alfresco/settings/share-config-custom.xml.$authtype"

orig="tomcat/shared/classes/alfresco-global.properties.orig"
origshared="tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml.orig"
shared="tomcat/shared/classes/alfresco/web-extension/share-config-custom.xml"

if [ ! -d "tomcat" ]
then
	echo "The current directory does not appear to be an Alfresco install dir."
	exit 0
fi

if [ "$authtype" == "ntlm" ]
then
	echo $authannounce 
	cp $orig $globsettings
	cp $origshared $shared

elif [ "$authtype" == "ldap-ad" ]
then
	echo $authannounce 
	echo $adwarn
	cat $settingsfile >> $globsettings

elif [ "$authtype" == "passthru" ]
then
	echo $authannounce 
	echo $adwarn 
        cat $settingsfile >> $globsettings
 	cp $sharedfile $shared

elif [ "$authtype" == "kerberos" ]
then
	echo $authannounce
	echo $adwarn
	cat $settingsfile >> $globsettings
	cp $sharedfile $shared
fi
