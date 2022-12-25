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
workingDir="`curDir`" #run script from scripts directory

### imports
source $workingDir/ubuntuAptTools.sh

# Tests
isPackageInstalled 'mc' -p
isPackageInstalled 'git' -p
isPackageInstalled 'mcedit' -p
isPackageInstalled 'nodejs' -p
isPackageInstalled 'npm' -p
isPackageInstalled 'ruby' -p

aptContainsRepo 'webupd8team/java'
aptContainsRepo 'git-core/ppa'

aptAddRepo 'ppa:webupd8team/java'
