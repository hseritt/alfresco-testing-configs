#!/usr/bin/env bash

dbuser="root"
dbpass="alfresco"

mysql="mysql -u $dbuser -p${dbpass}"

db="alf$(echo $(basename $(pwd))|sed 's/\./_/g')"

echo "Recreating the database: $db"
$mysql -e "drop database $db"
$mysql -e "create database $db"
echo "Done."

echo "Deleting the contentstore."
rm -rf alf_data/contentstore/*
echo "Done."

echo "Removing Solr indexes and models."
rm -rf alf_data/solr/archive/SpacesStore/index
rm -rf alf_data/solr/archive-SpacesStore/alfrescoModels/*

rm -rf alf_data/solr/workspace/SpacesStore/index
rm -rf alf_data/solr/workspace-SpacesStore/alfrescoModels/*

echo "Removing any Solr 4 indexes and models."
rm -rf alf_data/solr4/index/archive/SpacesStore/index
rm -rf alf_data/solr4/index/workspace/SpacesStore/index
rm -rf alf_data/solr4/model/*
rm -rf alf_data/solr4/content/*
echo "Done."

echo "Repository reset finished."

