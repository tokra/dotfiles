#!/bin/bash
function existCommand () {
    type "$1" &> /dev/null ;
}

function notExistCommand () {
    if existCommand "$1" ; then
        return 1
    fi
    return 0
}

function notExistDir () {
   if [[ ! -d $1 ]] ; then
        return 0
   fi
   return 1
}

function gitClone () {
    printf 'Git:\n> Cloning %s\n' "$1"
    git clone $1
}