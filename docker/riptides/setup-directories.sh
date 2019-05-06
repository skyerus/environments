#!/bin/bash
#-
#- Set up directories
#-


#- Change to script directory
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo chown -R ${user}:${user} ./

sudo touch ~/.docker_bash_history
touch log/riptides-api/app/error.log
touch log/riptides-api/app/debug.log
touch log/riptides-api/app/info.log
sudo chmod -R 0777 log
