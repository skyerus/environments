#!/usr/bin/env bash

#---------------------------------------
# USAGE: Add this to your bash profile
# so these helpers are available all the time
#
#
# To install add:
# . /path/to/bash-helpers.sh
# to your ~/.bashrc (linux) or ~/.bash_profile (osx)
#
# NOTE: at the begining the dot and the space is important!
#
#---------------------------------------

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

alias musicenvs="cd $DIR/docker/music"
alias ripenvs="cd $DIR/docker/riptides"
alias docker-music-up="sudo chown -R ${user}:${user} $DIR; musicenvs; music-gen-env; sudo docker-compose up -d; genhosts"
alias docker-music-down='musicenvs; sudo docker-compose down'
alias docker-rip-up="sudo chown -R ${user}:${user} $DIR; ripenvs; rip-gen-env; sudo docker-compose up -d; genhosts"
alias docker-rip-down='ripenvs; sudo docker-compose down'
alias music-gen-env='musicenvs; . generate_env.sh'
alias rip-gen-env='ripenvs; . generate_env.sh'
alias genhosts="cd $DIR; ./generate-host-file.sh"
alias ripdebug="tail -f -n100 $DIR/docker/riptides/log/riptides-api/app/debug.log"

dockip() {
  c=$@
  ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$c")
  if [ -z "$ip" ]
  then
    #- OSX doesn't have grep -P :o/
    #ip=$(docker inspect "$c" | grep -P -io '(?<="IPAddress": ")([0-9]+\.[0-9]+.[0-9]+\.[0-9]+)')
    ip=$(docker inspect "$c" | perl -nle 'print $& if m{(?<="IPAddress": ")([0-9]+\.[0-9]+.[0-9]+\.[0-9]+)}')
    if [ -z "$ip" ]
    then
      ip=$(docker inspect --format '{{ .NetworkSettings.Networks.airlocal_default.IPAddress }}' "$c")
    fi
  fi

  if [ "$ip" = "<no value>" ]
  then
    ip=""
  fi

  echo $ip
}
