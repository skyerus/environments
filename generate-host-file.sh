#!/bin/bash
#-
#- Update host file.
#-


#- Change to script directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

cd $DIR

OS=$(uname -s)

#- requires the bash helpers
. ./bash-helpers.sh

if [ "$OS" = "Linux" ] || [ $OS = "Darwin" ]
then
   sudo="sudo "
fi

#- Load colours and other tings
. ./_colours.sh

hostfile=/etc/hosts
backuphostfile=/tmp/hosts.bak.$(date +%Y%m%d%H%M%S)
dockerhostlist=/tmp/hostsfordocker
tmphostfile=/tmp/tmphosts

marker_start="### START DOCKER HOSTS"
marker_end="### END DOCKER HOSTS"

backupfile() {
    (>&2 echo -e "$star Backup created: $backuphostfile")
    cp -p "${hostfile}" "${backuphostfile}"
}

addmarkerstohostsfile() {
    file=$1
    (>&2 echo -e "$star Checking for hostfile marker: ${g}${marker_start}")
    #- add markers to the host file, if they are not there
    if ! grep -Fxq "$marker_start" $file
    then
       (>&2 echo -e "      ${d}...${y}not found${d}, adding.")
       echo -e "$marker_start\n \n$marker_end\n" >> $file
    fi
}

dockipsforhostfile() {
  (>&2 echo -e "$star Generating host list")

  for container in $(docker ps -q)
  do
     name=$(docker inspect --format '{{ .Name }}' "$container")
     name=${name:1}
#     if [ "$name" = "air-httpd-dashboard" ]
#     then
#        name="$name dashboard.local vouchers.local"
#     elif [ "$name" = "air-httpd-issuancemicrosites" ]
#     then
#        name="$name issuanceportal.local"
#     fi
     alias=$(docker inspect --format="{{range .NetworkSettings.Networks}}{{.Aliases}}{{end}}" "$container")
       alias=${alias:1}
       alias=${alias::-1}


       set -f                      # avoid globbing (expansion of *).
       array=(${alias// / })
       for i in "${!array[@]}"
       do
           if [ ${array[i]} != $container ]
               then
               echo "$(dockip $container)     ${array[i]}"
           fi
       done

#     echo "$(dockip $container)     ${name}"
  done
}

updatehostfile() {
    (>&2 echo -e "$star Compiling new host file.")

    file=$1
    filetoadd=$2

    lead="^$marker_start\$"
    tail="^$marker_end\$"
    output=$(sed -e "/$lead/,/$tail/{ /$lead/{p; r ${filetoadd}
            }; /$tail/p; d;}"  ${file})

    echo "$output" > $file

}

installhostfile() {
    (>&2 echo -e "$star Installing new host file")
    file=$1

    if [ -s "$file" ]
    then 
        ${sudo}cp -p "${file}" "${hostfile}"
    fi

}

docleanup() {
    (>&2 echo -e "$star Cleaning up.")
    rm -f ${dockerhostlist}
    rm -f ${tmphostfile}
}


    (>&2 echo -e " ")


backupfile


cp -p $hostfile $tmphostfile 


addmarkerstohostsfile $tmphostfile


dockipsforhostfile > $dockerhostlist


updatehostfile $tmphostfile $dockerhostlist


installhostfile $tmphostfile


docleanup



