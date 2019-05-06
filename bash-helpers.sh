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

alias APIDIR="cd $DIR/docker/riptides/api"
alias musicenvs="cd $DIR/docker/music"
alias ripenvs="cd $DIR/docker/riptides"
alias docker-music-up="sudo chown -R ${user}:${user} $DIR; musicenvs; music-gen-env; sudo docker-compose up -d; genhosts"
alias docker-music-down='musicenvs; sudo docker-compose down'
alias docker-rip-up="sudo chown -R ${user}:${user} $DIR; ripenvs; rip-gen-env; sudo docker-compose up -d; genhosts; sudo chmod 077 /var/run/docker.sock"
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

dockbash() {
  docker exec -it $@ bash
}

dockips() {

  echo " IPs of running docker containers"
  echo " "
  echo "   Container ID     IP               Name                            URL"
  echo "  —————————————————————————————————————————————————————————————————————————————————————————————————————————————"
  for container in $(docker ps -q)
  do
     name=$(docker inspect --format '{{ .Name }}' "$container")
     name=${name:1}

     port=$(docker port ${container} | grep 80/tcp | cut -d: -f2)
     ip=$(dockip ${container})

     echo -ne "   $g${container}     $d$(strpad $ip 15)  $b$(strpad ${name} 30)"


     if [ -n "$port" ]
     then
         if [ "$name" = "dashboard.local" ]
         then
             host="dashboard.local:$port dashboard.local"
         elif [ "$name" = "phoenix-reborn.local" ]
         then
             host="localhost:$port phoenix-reborn.local"
         elif [ "$OS" = "Linux" ]
         then
             host=$name
         else
             host="localhost:$port"
         fi

         for ep in $host
         do
           echo -ne "  ${d}http://${ep}/"
         done
     fi
     echo " "
  done
  echo -e "$d"
}

strpad() {
    str=$1
    len=$2
    padlen=$(( $len - ${#str} ))
    if [ $padlen -gt 0 ]
    then
       pad=$(head -c $padlen < /dev/zero | tr '\0' ' ')
    fi
    echo "${str}${pad}"
}
