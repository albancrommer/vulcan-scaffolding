#!/bin/bash
# First, set up an usage function
usage(){
    SCRIPT_NAME=$(basename ${0})
    DOC=$(cat <<DOC_BLOCK

    SYNOPSIS
       ${SCRIPT_NAME} [-h] 
    DESCRIPTION
       This is a generator for vulcan projects
    OPTIONS
       -h, --help                    Print this help
    ACTIONS 
        package         Generates a new package
        collection      Generates a new collection / schema
    EXAMPLES
       ${SCRIPT_NAME} -h
DOC_BLOCK
    # KEEP previous line at col 0 for "Here Tag" to work
    ) ; 

    echo "$DOC"
}

# It should set up GLOBAL path variables

# The "scaffolding" project root dir
SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd )

# The meteor / vulcan root dir
APP_PATH="/tmp/vulcan"

# The meteor / vulcan packages dir
PACKAGE_PATH="${APP_PATH}/packages"

# It should source helpers
source ${SCRIPT_PATH}/lib/functions.sh
source "$SCRIPT_PATH/lib/copy_template.sh"

# It should read the args
while true ; do
    [ -z "$1" ] && break; # No more args
    # Parse args
    case "$1" in
        (-p | --package)
            PACKAGE_NAME="$2"
            shift
        ;;
        (-m | --module)
            MODULE_NAME="$2"
            shift
        ;;
        (-h | --help)
              usage ; exit 0;
            ;;
        (*) 
            # Set the action
            ACTION="$1"
            ;;
    esac
    shift
done

# It should require an action
[ -z "$ACTION" ] && panic "Missing action."

# It should a global dependencies variabl
declare -A GLOBAL_DEPENDENCIES=( [PACKAGE_NAME]="$PACKAGE_NAME" [MODULE_NAME]="$MODULE_NAME" ) 

case "$ACTION" in 
    (component|c)
        source "$SCRIPT_PATH/lib/create_component.sh"
        create_component
    ;;
    (module|m)
        source "$SCRIPT_PATH/lib/create_module.sh"
        create_module 
    ;;
    (package|p)
        source "$SCRIPT_PATH/lib/create_package.sh"
        PACKAGE_NAME=$(create_package)
        #meteor add $PACKAGE_NAME
    ;;
    (*)
        panic "Invalid action $ACTION requested"
    ;;
esac