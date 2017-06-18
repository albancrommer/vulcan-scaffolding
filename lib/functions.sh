#!/bin/bash


#
# returns 0 if a directory exists
# returns 1 otherwise
#
function directory_exists {
    if [[ -d "$1" ]]; then
        return 0
    fi
    return 1
}

function ask(){
    
    [ -n "$TEST" ] && { echo "test" ; exit ; }
    read -p "$1 "
    [ -z "$REPLY" ] && { red "waiting for reply."; return $( ask "$1" ); }
    echo "$REPLY"
}


function color(){
    local reset="\e[0m"
    local red="\e[31m"
    local green="\e[32m"
    local grey="\e[33m"
    col=${!1}
    echo -e "${col}${2}${reset}"
}

function green(){ color green "@"; } 
function grey(){ color grey "@"; } 
function red(){ color red "$@"; }
function panic(){ red "$1" ; exit 1 ; } 

##
# Basic helper, strips spaces, slashes, etc.
# Only chars, numbers, dash, underscore 
##
function sanitize(){
    echo ${@//[^a-zA-Z0-9-_]/}
}
