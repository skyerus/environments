#!/bin/bash

#theshell="bash"
#if [ -n "$ZSH_VERSION" ]
#then
#   theshell="zsh"
#fi

d="\033[39m" #- Default
r="\033[31m" #- Red
g="\033[92m" #- Green
b="\033[96m" #- Blue
y="\033[93m" #- Yellow

if [ -n "$ZSH_VERSION" ]
then

    d=$'\E[00;39m' #- Default
    r=$'\E[00;31m' #- Red
    g=$'\E[00;92m' #- Green
    b=$'\E[00;96m' #- Blue
    y=$'\E[00;93m' #- Yellow

   autoload colors
   colors

fi


star=" $y★$d"


