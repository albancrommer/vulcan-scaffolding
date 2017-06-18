##
# @param 1 package name
##
function create_model(){
    
    panic "finish create_model"

    # It should require a global name
    if [ -n "$1" ] ; then 
        PACKAGE_NAME="$1"
    else 
        PACKAGE_NAME=$(ask "Please give the package name:")
    fi

    # It should require a valid package 
    directory_exists "$PACKAGE_PATH/$PACKAGE_NAME" || panic "Missing package $PACKAGE_NAME"
   
    # It should request the module 
    QUERY_MODULE=$( ask "Please provide module to attach component to:" )

    # It should sanitize the module
    MODULE=$( sanitize "$QUERY_MODULE" )

    # It should check the module exists
    directory_exists "$PACKAGE_PATH/$PACKAGE_NAME/modules/$MODULE" || panic "Module doesn't exist"

    DESCRIPTION=$(ask "Please provide a description. Ex: 'Provides a movie list'")
    model_NAME=$(ask "Please provide a model name. Ex: 'MyMovieList'")
    COLLECTION_NAME=$(ask "Please provide a collection name. Ex: 'Movie'")
    COLLECTION_NAME_C=${COLLECTION_NAME^}
    COLLECTION_NAME_U=${COLLECTION_NAME,,}

    # It should copy the model
    copy_template model.js "${PACKAGE_PATH}/${PACKAGE_NAME}/models/${MODULE}/${model_NAME}.jsx" \
        %DESCRIPTION%="$DESCRIPTION" \
        %model_NAME%="$model_NAME" \
        %COLLECTION_NAME_C%="$COLLECTION_NAME_C" \
        %COLLECTION_NAME_U%="$COLLECTION_NAME_U"

    
    
}

