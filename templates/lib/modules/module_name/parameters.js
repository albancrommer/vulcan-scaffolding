import { addCallback } from 'meteor/vulcan:core';

function sortByYear (parameters, terms) {
  return {
    selector: parameters.selector, 
    options: {...parameters.options, sort: {created_at: -1}}
  };
}

addCallback('%MODULE_NAME_U%.parameters', sortByYear);