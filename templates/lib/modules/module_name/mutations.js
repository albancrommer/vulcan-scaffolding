/*

Define the three default mutations:

- new (e.g.: %MODULE_NAME_U%sNew(document: %MODULE_NAME_U%sInput) : %MODULE_NAME_C% )
- edit (e.g.: %MODULE_NAME_U%sEdit(documentId: String, set: %MODULE_NAME_U%sInput, unset: moviesUnset) : %MODULE_NAME_C% )
- remove (e.g.: %MODULE_NAME_U%sRemove(documentId: String) : %MODULE_NAME_C% )

Each mutation has:

- A name
- A check function that takes the current user and (optionally) the document affected
- The actual mutation

*/

import { newMutation, editMutation, removeMutation, Utils } from 'meteor/vulcan:core';
import Users from 'meteor/vulcan:users';

const mutations = {

  new: {
    
    name: '%MODULE_NAME_U%sNew',
    
    check(user) {
      if (!user) return false;
      return Users.canDo(user, '%MODULE_NAME_U%s.new');
    },
    
    mutation(root, {document}, context) {
      
      Utils.performCheck(this.check, context.currentUser, document);

      return newMutation({
        collection: context.%MODULE_NAME_C%s,
        document: document, 
        currentUser: context.currentUser,
        validate: true,
        context,
      });
    },

  },

  edit: {
    
    name: '%MODULE_NAME_U%sEdit',
    
    check(user, document) {
      if (!user || !document) return false;
      return Users.owns(user, document) ? Users.canDo(user, '%MODULE_NAME_U%s.edit.own') : Users.canDo(user, `%MODULE_NAME_U%s.edit.all`);
    },

    mutation(root, {documentId, set, unset}, context) {

      const document = context.%MODULE_NAME_C%s.findOne(documentId);
      Utils.performCheck(this.check, context.currentUser, document);

      return editMutation({
        collection: context.%MODULE_NAME_C%s, 
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

    name: '%MODULE_NAME_U%sRemove',
    
    check(user, document) {
      if (!user || !document) return false;
      return Users.owns(user, document) ? Users.canDo(user, '%MODULE_NAME_U%s.remove.own') : Users.canDo(user, `%MODULE_NAME_U%s.remove.all`);
    },
    
    mutation(root, {documentId}, context) {

      const document = context.%MODULE_NAME_C%s.findOne(documentId);
      Utils.performCheck(this.check, context.currentUser, document);

      return removeMutation({
        collection: context.%MODULE_NAME_C%s, 
        documentId: documentId, 
        currentUser: context.currentUser,
        validate: true,
        context,
      });
    },

  },

};

export default mutations;
