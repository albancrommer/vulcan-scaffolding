/*

Define the three default mutations:

- new (e.g.: %MODULE_NAME_U%New(document: %MODULE_NAME_U%Input) : %MODULE_NAME_C% )
- edit (e.g.: %MODULE_NAME_U%Edit(documentId: String, set: %MODULE_NAME_U%Input, unset: moviesUnset) : %MODULE_NAME_C% )
- remove (e.g.: %MODULE_NAME_U%Remove(documentId: String) : %MODULE_NAME_C% )

Each mutation has:

- A name
- A check function that takes the current user and (optionally) the document affected
- The actual mutation

*/

import { newMutation, editMutation, removeMutation, Utils } from 'meteor/vulcan:core';
import Users from 'meteor/vulcan:users';

const mutations = {

  new: {
    
    name: '%MODULE_NAME_U%New',
    
    check(user) {
      if (!user) return false;
      return Users.canDo(user, '%MODULE_NAME_U%.new');
    },
    
    mutation(root, {document}, context) {
      
      Utils.performCheck(this.check, context.currentUser, document);

      return newMutation({
        collection: context.%MODULE_NAME_C%,
        document: document, 
        currentUser: context.currentUser,
        validate: true,
        context,
      });
    },

  },

  edit: {
    
    name: '%MODULE_NAME_U%Edit',
    
    check(user, document) {
      if (!user || !document) return false;
      return Users.owns(user, document) ? Users.canDo(user, '%MODULE_NAME_U%.edit.own') : Users.canDo(user, `%MODULE_NAME_U%.edit.all`);
    },

    mutation(root, {documentId, set, unset}, context) {

      const document = context.%MODULE_NAME_C%.findOne(documentId);
      Utils.performCheck(this.check, context.currentUser, document);

      return editMutation({
        collection: context.%MODULE_NAME_C%, 
        documentId: documentId, 
        set: set, 
        unset: unset, 
        currentUser: context.currentUser,
        validate: true,
        context,
      });
    },

  },
  
  remove: {

    name: '%MODULE_NAME_U%Remove',
    
    check(user, document) {
      if (!user || !document) return false;
      return Users.owns(user, document) ? Users.canDo(user, '%MODULE_NAME_U%.remove.own') : Users.canDo(user, `%MODULE_NAME_U%.remove.all`);
    },
    
    mutation(root, {documentId}, context) {

      const document = context.%MODULE_NAME_C%.findOne(documentId);
      Utils.performCheck(this.check, context.currentUser, document);

      return removeMutation({
        collection: context.%MODULE_NAME_C%, 
        documentId: documentId, 
        currentUser: context.currentUser,
        validate: true,
        context,
      });
    },

  },

};

export default mutations;
