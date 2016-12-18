#!/bin/bash

# resolve currentDirectory even if symlink
source="${BASH_SOURCE[0]}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
  currentDirectory="$( cd -P "$( dirname "$source" )" && pwd )"
  source="$(readlink "$source")"
  [[ $source != /* ]] && source="$currentDirectory/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
my_dir="$( cd -P "$( dirname "$source" )" && pwd )"

source $my_dir/common.sh
source $my_dir/os.sh

#####################################################################
# Java
if isMacOs ; then
  export JAVA_HOME=$(/usr/libexec/java_home)
elif isUbuntu ; then
  if notExistCommand java ; then
    printf 'Installation:\n> APT installing java (ubuntu)'
    sudo add-apt-repository ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install -y oracle-java8-installer
  fi 
fi