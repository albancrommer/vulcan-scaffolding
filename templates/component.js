/**
 * @description %DESCRIPTION%
 */
import React from 'react';
import { Components, registerComponent, getFragment } from "meteor/vulcan:core";

import %COLLECTION_NAME_C% from '../../modules/%COLLECTION_NAME_U%/collection.js';

const %COMPONENT_NAME% = ({documentId, closeModal}) =>

  <Components.SmartForm 
    collection={%COLLECTION_NAME_C%}
    documentId={documentId}
    mutationFragment={getFragment('MoviesItemFragment')}
    showRemove={true}
    successCallback={document => {
      closeModal();
    }}
  />

export default %COMPONENT_NAME%;
