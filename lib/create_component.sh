##
# @param 1 package name
##
function create_component(){
    
    # It should require a global name
    if [ -n "$1" ] ; then 
        PACKAGE_NAME="$1"
    else 
        PACKAGE_NAME=$(ask "Please give the package name:")
    fi

    # It should require a valid package 
    directory_exists "$PACKAGE_PATH/$PACKAGE_NAME" || panic "Missing package $PACKAGE_NAME"
   
    # It should request the component parent 
    QUERY_COMPONENT_PARENT=$( ask "Please provide component's parent:" )

    # It should sanitize the component parent
    COMPONENT_PARENT=$( sanitize "$QUERY_COMPONENT_PARENT" )

    # It should create the parent if need be
    directory_exists "$PACKAGE_PATH/$PACKAGE_NAME/components/$COMPONENT_PARENT" || {

        grey "Creating $PACKAGE_PATH/$PACKAGE_NAME/components/$COMPONENT_PARENT"
        mkdir -p "$PACKAGE_PATH/$PACKAGE_NAME/components/$COMPONENT_PARENT"

    }

    DESCRIPTION=$(ask "Please provide a description. Ex: 'Provides a movie list'")
    COMPONENT_NAME=$(ask "Please provide a component name. Ex: 'MyMovieList'")
    COLLECTION_NAME=$(ask "Please provide a collection name. Ex: 'Movie'")
    COLLECTION_NAME_C=${COLLECTION_NAME^}
    COLLECTION_NAME_U=${COLLECTION_NAME,,}

    # It should copy the component
    copy_template component.js "${PACKAGE_PATH}/${PACKAGE_NAME}/components/${COMPONENT_PARENT}/${COMPONENT_NAME}.jsx" \
        %DESCRIPTION%="$DESCRIPTION" \
        %COMPONENT_NAME%="$COMPONENT_NAME" \
        %COLLECTION_NAME_C%="$COLLECTION_NAME_C" \
        %COLLECTION_NAME_U%="$COLLECTION_NAME_U"

    
}
