##
# @param 1 template TARGET_FILE (source), must be in "templates" dir, ex: "component.js"
# @param 2 destination TARGET_FILE (destination), absolute ex: "/srv/packages/foo/package.js"
# @param 3,... replacement in the "VAR=VALUE" form, ex: "%NAME%=foo"
##
function copy_template(){


    # It should read the template path 
    [ -z "$1" ] && panic "Missing template path"
    TEMPLATE="$1"
    shift
    [ ! -e "${SCRIPT_PATH}/templates/${TEMPLATE}" ] && panic "Missing template source"

    # It should read the destination path
    [ -z "$1" ] && panic "Missing destination path"
    TARGET_FILE="$1"
    shift
    
    # It should handle the case of existing TARGET_FILEs
    # @todo

    # It should create the directory
    TARGET_DIR=$( dirname "$TARGET_FILE" )
    directory_exists "$TARGET_DIR" || mkdir -p "$TARGET_DIR"

    # It should copy the template to final path
    cp "${SCRIPT_PATH}/templates/${TEMPLATE}" "$TARGET_FILE"

    # It should replace subsequent arguments
    while [ -n "$1" ] ; do
        VAR=${1%=*}
        VALUE=${1#*=}
        shift
        sed -i "s!$VAR!$VALUE!g" $TARGET_FILE
    done 

    # It should inform about success
    green "Successfully created $TARGET_FILE" 

}

