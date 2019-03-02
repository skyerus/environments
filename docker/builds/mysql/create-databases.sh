#!/bin/bash

#- WORK IN PROGRESS

dbs="MUSIC"


mysql="mysql -pmusic"

for db in "$dbs"
do
    sqlfile = "create-empty-${db}.sql"
    if [ -f "$sqlfile" ]
    then
        cat "$sqlfile" | $mysql
    else
        echo "CREATE DATABASE IF NOT EXISTS ${db} DEFAULT CHARACTER SET utf8_bin" | $mysql
    fi
done


