#!/usr/bin/env bash
#-
#- generate .env file
#-

ENVFILE=.env

STAR=" $E[93m★$E[39m"

DUSER=app
DGROUP=app

IDU=$(id -u)
IDG=$(id -g)

## Get wifi ip address
HOST_MACHINE_IP=$(ifconfig wlp2s0 | grep 'inet' | awk '{print $2}' | cut -f2 -d: | cut -f1 -d: | sed '/^\s*$/d')

if [ -z "$HOST_MACHINE_IP" ]
then
    ## Get wired ip address
    HOST_MACHINE_IP=$(ifconfig enp4s0 | awk '/inet addr/{split($2,a,":"); print a[2]}')
fi

if [ -z "$HOST_MACHINE_IP" ]
then
    ## Get default ip address
    HOST_MACHINE_IP=$(ip route get 2 | awk -F'[: ]+' '{ print $7 }')
fi

if [ -z "$HOST_MACHINE_IP" ]
then
    ## Get wired ip address
    HOST_MACHINE_IP=$(ip addr show enx00249b41a7b6 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
fi

genenvfile() {
  (>&2 echo -e "$STAR Generating env File")
  echo "DOCKER_USER=$DUSER"
  echo "DOCKER_GROUP=$DGROUP"
  echo "HOST_USER_ID=$IDU"
  echo "HOST_GROUP_ID=$IDG"
  echo "HOST_ADDRESS=$HOST_MACHINE_IP"

  (>&2 echo -e "$STAR Done")
}

genenvfile > $ENVFILE