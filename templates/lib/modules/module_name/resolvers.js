/*

Three resolvers are defined:

- list (e.g.: %MODULE_NAME_U%sList(terms: JSON, offset: Int, limit: Int) )
- single (e.g.: %MODULE_NAME_U%sSingle(_id: String) )
- listTotal (e.g.: %MODULE_NAME_U%sTotal )

*/

import { addGraphQLResolvers } from 'meteor/vulcan:core';

// basic list, single, and total query resolvers
const resolvers = {

  list: {

    name: '%MODULE_NAME_U%sList',

    resolver(root, {terms = {}}, context, info) {
      let {selector, options} = context.%MODULE_NAME_C%s.getParameters(terms, {}, context.currentUser);
      return context.%MODULE_NAME_C%s.find(selector, options).fetch();
    },

  },

  single: {
    
    name: '%MODULE_NAME_U%sSingle',

    resolver(root, {documentId}, context) {
      const document = context.%MODULE_NAME_C%s.findOne({_id: documentId});
      return context.Users.restrictViewableFields(context.currentUser, context.%MODULE_NAME_C%s, document);
    },
  
  },

  total: {
    
    name: '%MODULE_NAME_U%sTotal',
    
    resolver(root, {terms = {}}, context) {
      const {selector, options} = context.%MODULE_NAME_C%s.getParameters(terms, {}, context.currentUser);
      return context.%MODULE_NAME_C%s.find(selector, options).count();
    },
  
  }
};

// add the "user" resolver for the %MODULE_NAME_C% type separately
const %MODULE_NAME_U%UserResolver = {
  %MODULE_NAME_C%: {
    user(%MODULE_NAME_U%, args, context) {
      return context.Users.findOne({ _id: %MODULE_NAME_U%.userId }, { fields: context.Users.getViewableFields(context.currentUser, context.Users) });
    },
  },
};
addGraphQLResolvers(%MODULE_NAME_U%UserResolver);

export default resolvers;