# Setup

## Docker

For installation follow the instructions [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04)

## Docker-compose

For installation follow the instructions [here](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04)

## Git

For installation follow the instructions [here](https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-18-04-quickstart)

To set up an ssh key follow [this](http://wiki.paparazziuav.org/wiki/Github_manual_for_Ubuntu)

## Environments

Make sure you are in your home directory `cd ~/`
```
git clone git@github.com:skyerus/environments.git
echo '. ~/environments/bash-helpers.sh' >> ~/.bashrc
. ~/environments/docker/riptides/setup-directories.sh
bash
```

Before starting the containers make sure you have git cloned all of the listed projects in the relevant docker-compose.yml file into `~/web`

Start containers: `docker-rip-up`

Down containers: `docker-rip-down`
