#!/bin/bash
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