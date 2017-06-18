function create_package(){
    # It should require a global name
    QUERY_PACKAGE_NAME=$(ask "Please give the package name:")

    # It should sanitize the name
    PACKAGE_NAME=$( sanitize $QUERY_PACKAGE_NAME)

    # It should create the package directories
    cat $SCRIPT_PATH/structures/package.lst | while read DIR; do mkdir -p "${PACKAGE_PATH}/${PACKAGE_NAME}/${DIR}"; done

    # It should generate the package.js file
    copy_template "package.js" ${PACKAGE_PATH}/${PACKAGE_NAME}/package.js "%PACKAGE_NAME%=$PACKAGE_NAME"

    # It should finish
    echo "$PACKAGE_NAME"
    
}

