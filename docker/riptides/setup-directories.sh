#!/bin/bash
#-
#- Set up directories
#-


#- Change to script directory

sudo chown -R ${user}:${user} ./

touch ~/.docker_bash_history
mkdir -p log/riptides-api
chmod -R 0777 log
