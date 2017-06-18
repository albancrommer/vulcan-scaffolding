/*

The main %MODULE_NAME_C%s collection definition file.

*/

import { createCollection } from 'meteor/vulcan:core';
import schema from './schema.js';
import resolvers from './resolvers.js';
import './fragments.js';
import mutations from './mutations.js';
import './permissions.js';
import './parameters.js';

const %MODULE_NAME_C%s = createCollection({

  collectionName: '%MODULE_NAME_C%s',

  typeName: '%MODULE_NAME_C%',

  schema,
  
  resolvers,

  mutations,

});

export default %MODULE_NAME_C%s;
