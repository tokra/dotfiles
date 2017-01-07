#!/bin/bash
### variables
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
source $CD/scripts/os.sh

### main
# link profile scripts to home dir
source $CD/scripts/link.sh

# source profiles scripts
if isMacOs ; then
    printf "\nSourcing .bash_profile (macOs)...\n"
    source ~/.bash_profile
    echo "Sourcing .bash_profile (macOs)... done"
fi
if isUbuntu ; then
    printf "\nSourcing .bashrc (ubuntu)\n"
    source ~/.bashrc
    echo "Sourcing .bashrc (ubuntu).. done"
fi
