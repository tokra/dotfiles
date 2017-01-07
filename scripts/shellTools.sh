#!/bin/bash

function stringContains() {
    FULL_STRING=$1
    STRING_TO_FIND=$2
    if [[ $FULL_STRING == *"$STRING_TO_FIND"* ]] ; then
        return 0
    fi
    return 1
}
