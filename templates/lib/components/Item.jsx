/* 

An item in the %COLLECTION_NAME_U%s list.
Wrapped with the "withCurrentUser" container.

*/

import React from 'react';
import { Components, registerComponent } from 'meteor/vulcan:core';

import %COLLECTION_NAME_C%s from '../../modules/%COLLECTION_NAME_U%s/collection.js';
import %COLLECTION_NAME_C%sEditForm from './%COLLECTION_NAME_C%sEditForm.jsx';

const %COLLECTION_NAME_C%sItem = ({%COLLECTION_NAME_U%, currentUser}) =>

  <div style={{paddingBottom: "15px",marginBottom: "15px", borderBottom: "1px solid #ccc"}}>

    {/* document properties */}
    
    <h4>{%COLLECTION_NAME_U%.name} ({%COLLECTION_NAME_U%.year})</h4>
    <p>{%COLLECTION_NAME_U%.review} – {%COLLECTION_NAME_U%.user && %COLLECTION_NAME_U%.user.displayName}</p>
    
    {/* edit document form */}

    {%COLLECTION_NAME_C%s.options.mutations.edit.check(currentUser, %COLLECTION_NAME_U%) ? 
      <Components.ModalTrigger label="Edit %COLLECTION_NAME_C%">
        <%COLLECTION_NAME_C%sEditForm currentUser={currentUser} documentId={%COLLECTION_NAME_U%._id} />
      </Components.ModalTrigger>
      : null
    }

  </div>

export default %COLLECTION_NAME_C%sItem;