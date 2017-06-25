/* 

A component to configure the "new %COLLECTION_NAME_U%" form.

*/

import React from 'react';
import { Components, registerComponent, withCurrentUser, getFragment } from 'meteor/vulcan:core';

import %COLLECTION_NAME_C%s from '../../modules/%COLLECTION_NAME_U%s/collection.js';

const %COLLECTION_NAME_C%sNewForm = ({currentUser}) =>

  <div>

    {%COLLECTION_NAME_C%s.options.mutations.new.check(currentUser) ?
      <div style={{marginBottom: '20px', paddingBottom: '20px', borderBottom: '1px solid #ccc'}}>
        <h4>Insert New Document</h4>
        <Components.SmartForm 
          collection={%COLLECTION_NAME_C%s}
          mutationFragment={getFragment('%COLLECTION_NAME_C%sItemFragment')}
        /> 
      </div> :
      null
    }

  </div>

export default withCurrentUser(%COLLECTION_NAME_C%sNewForm);