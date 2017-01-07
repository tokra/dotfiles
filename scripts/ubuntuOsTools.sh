#!/bin/bash

### variables & functions
# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

### imports
source $my_dir/shellTools.sh

function getJavaHome() {
    JAVA_VERSION="$1"
    JAVA_HOME="`update-java-alternatives -l | grep $JAVA_VERSION | cut -d"/" -f2- | xargs -I "%" echo /%`"
    echo $JAVA_HOME
}

function hasEnvJavaHome() {
    ENV_JAVA_HOME="`cat /etc/environment | grep JAVA_HOME`"
    if stringContains "$ENV_JAVA_HOME" "JAVA_HOME" ; then
	#echo "JAVA_HOME exists: '$ENV_JAVA_HOME'" 
        return 0
    fi
    #echo "JAVA_HOME does not exist !"
    return 1
}

#getJavaHome 'java-8-oracle'
hasEnvJavaHome
