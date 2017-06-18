##
# @param 1 template file (source), must be in "templates" dir, ex: "component.js"
# @param 2 destination file (destination), absolute ex: "/srv/packages/foo/package.js"
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
    FILE="$1"
    shift
    
    # It should handle the case of existing files
    # @todo

    # It should copy the template to final path
    cp "${SCRIPT_PATH}/templates/${TEMPLATE}" "$FILE"

    # It should replace subsequent arguments
    while [ -n "$1" ] ; do
        VAR=${1%=*}
        VALUE=${1#*=}
        shift
        sed -i "s!$VAR!$VALUE!" $FILE
    done 

}

