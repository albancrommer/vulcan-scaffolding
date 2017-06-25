/* 

A component to configure the "edit %COLLECTION_NAME_U%" form.

*/

import React from 'react';
import { Components, registerComponent, getFragment } from "meteor/vulcan:core";

import %COLLECTION_NAME_C%s from '../../modules/%COLLECTION_NAME_U%s/collection.js';

const %COLLECTION_NAME_C%sEditForm = ({documentId, closeModal}) =>

  <Components.SmartForm 
    collection={%COLLECTION_NAME_C%s}
    documentId={documentId}
    mutationFragment={getFragment('%COLLECTION_NAME_C%sItemFragment')}
    showRemove={true}
    successCallback={document => {
      closeModal();
    }}
  />

export default %COLLECTION_NAME_C%sEditForm;