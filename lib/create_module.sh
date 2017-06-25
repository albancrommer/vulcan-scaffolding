##
# @param 1 package name
##
function create_module(){
    
    # It should require a package name
    if [ -n "${GLOBAL_DEPENDENCIES["PACKAGE_NAME"]}" ]; then
        PACKAGE_NAME="${GLOBAL_DEPENDENCIES["PACKAGE_NAME"]}"
    else 
        PACKAGE_NAME=$(ask "Please give the package name:")
    fi

    # It should require a valid package 
    directory_exists "$PACKAGE_PATH/$PACKAGE_NAME" || panic "Missing package $PACKAGE_NAME"
   
    # It should request the module name
    if [ -n "${GLOBAL_DEPENDENCIES["MODULE_NAME"]}" ]; then
        QUERY_MODULE="${GLOBAL_DEPENDENCIES["MODULE_NAME"]}"
    else 
        QUERY_MODULE=$( ask "Please provide module name:" )
    fi

    # It should sanitize the module
    MODULE_NAME=$( sanitize "$QUERY_MODULE" )
    MODULE_NAME_C=${MODULE_NAME^}
    MODULE_NAME_U=${MODULE_NAME,,}

    # It should create the module directory 
    mkdir "$PACKAGE_PATH/$PACKAGE_NAME/lib/modules/${MODULE_NAME}s" 

    # It should template the module files
    copy_template "lib/modules/module_name/collection.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}s/collection.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/fragments.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}s/fragments.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/mutations.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}s/mutations.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/parameters.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}s/parameters.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/permissions.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}s/permissions.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/resolvers.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}s/resolvers.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"
    copy_template "lib/modules/module_name/schema.js" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/${MODULE_NAME_U}s/schema.js" \
            %MODULE_NAME_C%="$MODULE_NAME_C" \
            %MODULE_NAME_U%="$MODULE_NAME_U"


    # It should plug the collection in the modules list
    echo -e "\n// The $MODULE_NAME_C collection\nimport './${MODULE_NAME_U}s/collection.js';" >> "$PACKAGE_PATH/$PACKAGE_NAME/lib/modules/$MODULE/index.js" 

    # It should create the components directory 
    mkdir "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/components/${MODULE_NAME_U}s" 


    # It should template the basic components
    for COMPONENT in EditForm Item List NewForm ; do 

        copy_template "lib/components/${COMPONENT}.jsx" "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/components/${MODULE_NAME_U}s/${MODULE_NAME_C}s${COMPONENT}.jsx" \
            %COLLECTION_NAME_C%="$MODULE_NAME_C" \
            %COLLECTION_NAME_U%="$MODULE_NAME_U"
    
    done
        # It should create a partial to import a route
        echo "
import ${MODULE_NAME_C}sList from '../components/${MODULE_NAME_U}s/${MODULE_NAME_C}sList.jsx';
addRoute({ name: '${MODULE_NAME_U}', path: '/${MODULE_NAME_U}', component: ${MODULE_NAME_C}sList });
" >>  "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/routes.js"


    # It should inform about success
    green "Successfully created module" 

}


