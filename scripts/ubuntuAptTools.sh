#!/bin/bash

### variables & functions
function curDir () { # resolve currentDirectory even if symlink
    while [ -h "${BASH_SOURCE[0]}" ]; do # resolve $source until the file is no longer a symlink
        currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
        source="$(readlink "$source")"
        [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    echo "$( cd -P "$( dirname "$source" )" && pwd )"
}
workingDir="`curDir`"

### imports
source $workingDir/shellTools.sh

### main
function isPackageInstalled () {
    IS_INSTALLED=`dpkg-query -W --showformat='${Status}\n' $1`
    if [ "$IS_INSTALLED" == "install ok installed" ]; then
        if [ -n "$2" ] && [ "$2" == "-p" ] ; then 
            echo "Package '$1' is installed !"
        fi
        return 0
    fi
    if [ -n "$2" ] && [ "$2" == "-p" ]; then 
        echo "package '$1' missing !"
    fi
    return 1
}

function aptContainsRepo () {
    REPO="$1"
    FOUND_MATCH=`grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep "$REPO" | head -1`
    if stringContains "$FOUND_MATCH" "$REPO" ; then
        echo "Repository: '$REPO' exists !"      
        return 0
    fi
    echo "Repository: '$REPO' missing !"
    return 1
}

function aptAddRepo () {
    REPO_FULL=$1
    REPO_SHORT=`echo $1 | cut -f2 -d":"`
    if ! aptContainsRepo "$REPO_SHORT" ; then
	printf 'Adding repository:\n> [Ubuntu/Linux] APT adding repo: %s\n' "$REPO_FULL"
        sudo add-apt-repository -y "$REPO_FULL"
        sudo apt-get update
    fi
}

function aptGetInstall () {
    if ! isPackageInstalled "$1" ; then
        printf 'Installation:\n> [Ubuntu/Linux] APT installing: %s\n' "$1"
        sudo apt-get install "$1"
    fi
}


