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
CD="`curDir`"

### imports
source $CD/common.sh
source $CD/os.sh
source $CD/ubuntuAptTools.sh

### main

# Java
if isMacOs ; then
    export JAVA_HOME=$(/usr/libexec/java_home)
elif isUbuntu ; then
    aptAddRepo 'ppa:webupd8team/java'

    # Java 6
    JAVA6="oracle-java6-installer"
    if ! isPackageInstalled "$JAVA6" ; then 
        echo "$JAVA6 shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
        aptGetInstall "$JAVA6"
    fi

    # Java 7
    JAVA7="oracle-java7-installer"
    if ! isPackageInstalled "$JAVA7" ; then 
        echo "$JAVA7 shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
        aptGetInstall "$JAVA7"
    fi

    # Java 8
    JAVA8="oracle-java8-installer"
    if ! isPackageInstalled "$JAVA8" ; then 
        echo "$JAVA8 shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
        aptGetInstall "$JAVA8"
        aptGetInstall 'oracle-java8-set-default'
    fi   
fi
