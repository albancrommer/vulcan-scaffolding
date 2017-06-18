##
# @param 1 package name
##
function create_component(){
    
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
        MODULE_NAME="${GLOBAL_DEPENDENCIES["MODULE_NAME"]}"
    else 
        MODULE_NAME=$( ask "Please provide module name:" )
    fi

    # It should require a valid module 
    directory_exists "$PACKAGE_PATH/$PACKAGE_NAME/lib/modules/$MODULE_NAME" || panic "Module doesn't exist"

    DESCRIPTION=$(ask "Please provide a description for your component. Ex: 'Provides a movie list': ")
    COMPONENT_NAME=$(ask "Please provide a component name. Ex: 'MyMovieList': ")
    COLLECTION_NAME=$(ask "Please provide a collection name. Ex: 'Movie': ")
    COMPONENT_ROUTE=$(ask "Please provide a route. Ex: '/movies': ")
    COLLECTION_NAME_C=${COLLECTION_NAME^}
    COLLECTION_NAME_U=${COLLECTION_NAME,,}
    COMPONENT_NAME_C=${COMPONENT_NAME^}
    COMPONENT_NAME_U=${COMPONENT_NAME,,}

    # It should template the component
    copy_template component.js "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/components/${MODULE_NAME}/${COMPONENT_NAME}.jsx" \
        %DESCRIPTION%="$DESCRIPTION" \
        %COMPONENT_NAME%="$COMPONENT_NAME" \
        %COLLECTION_NAME_C%="$COLLECTION_NAME_C" \
        %COLLECTION_NAME_U%="$COLLECTION_NAME_U"

    # It should create a partial to import a route
    echo "
import ${COMPONENT_NAME} from '../components/${MODULE_NAME}/${COMPONENT_NAME}.jsx';
addRoute({ name: '${COMPONENT_NAME_U}', path: '${COMPONENT_ROUTE}', component: ${COMPONENT_NAME_C} });
" >>  "${PACKAGE_PATH}/${PACKAGE_NAME}/lib/modules/routes.js"
    
    # It should inform about success
    green "Successfully created component" 


}
