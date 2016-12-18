#!/bin/bash
function cmdExists () {
    type "$1" &> /dev/null ;
}