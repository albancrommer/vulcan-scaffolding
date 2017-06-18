##
# @param 1 package name
##
function create_module(){
    
    # It should require a global name
    if [ -n "$1" ] ; then 
        PACKAGE_NAME="$1"
    else 
        PACKAGE_NAME=$(ask "Please give the package name:")
    fi

    # It should require a valid package 
    directory_exists "$PACKAGE_PATH/$PACKAGE_NAME" || panic "Missing package $PACKAGE_NAME"
   
    # It should request the module 
    QUERY_MODULE=$( ask "Please provide module's name (ex: movies):" )

    # It should sanitize the module
    MODULE_NAME=$( sanitize "$QUERY_MODULE" )
    MODULE_NAME_C=${MODULE_NAME^}
    MODULE_NAME_U=${MODULE_NAME,,}

    # It should create the module directory 
    mkdir "$PACKAGE_PATH/$PACKAGE_NAME/lib/modules/$MODULE_NAME" 

    # It should template the module files
    copy_template "lib/modules/module_name/collection.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}/collection.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/fragments.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}/fragments.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/mutations.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}/mutations.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/parameters.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}/parameters.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/permissions.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}/permissions.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/resolvers.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}/resolvers.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/schema.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}/schema.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"


    # It should plug the collection in the modules list
    echo -e "\n// The $MODULE_NAME_C collection\nimport './${MODULE_NAME_U}/collection.js';" >> "$PACKAGE_PATH/$PACKAGE_NAME/lib/modules/$MODULE/index.js" 

    
}


