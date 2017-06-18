/* 

Register the GraphQL fragment used to query for data

*/

import { registerFragment } from 'meteor/vulcan:core';

registerFragment(`
  fragment %MODULE_NAME_C%ItemFragment on %MODULE_NAME_C% {
    _id
    createdAt
    userId
    user {
      displayName
    }
  }
`);