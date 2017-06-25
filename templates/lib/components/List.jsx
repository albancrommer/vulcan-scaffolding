/* 

List of %COLLECTION_NAME_U%s. 
Wrapped with the "withList" and "withCurrentUser" containers.

*/

import React from 'react';
import { Components, withList, withCurrentUser, Loading } from 'meteor/vulcan:core';

import %COLLECTION_NAME_C%s from '../../modules/%COLLECTION_NAME_U%s/collection.js';
import %COLLECTION_NAME_C%sItem from './%COLLECTION_NAME_C%sItem.jsx';
import %COLLECTION_NAME_C%sNewForm from './%COLLECTION_NAME_C%sNewForm.jsx';

const %COLLECTION_NAME_C%sList = ({results = [], currentUser, loading, loadMore, count, totalCount}) => 
  
  <div style={{maxWidth: '500px', margin: '20px auto'}}>

    {/* user accounts */}

    <div style={{padding: '20px 0', marginBottom: '20px', borderBottom: '1px solid #ccc'}}>
    
      <Components.AccountsLoginForm />
    
    </div>

    {loading ? 

      <Loading /> :

      <div className="%COLLECTION_NAME_U%s">
        
        {/* new document form */}

        <%COLLECTION_NAME_C%sNewForm />

        {/* documents list */}

        {results.map(%COLLECTION_NAME_U% => <%COLLECTION_NAME_C%sItem key={%COLLECTION_NAME_U%._id} %COLLECTION_NAME_U%={%COLLECTION_NAME_U%} currentUser={currentUser} />)}
        
        {/* load more */}

        {totalCount > results.length ?
          <a href="#" onClick={e => {e.preventDefault(); loadMore();}}>Load More ({count}/{totalCount})</a> : 
          <p>No more items.</p>
        }

      </div>
    }

  </div>

const options = {
  collection: %COLLECTION_NAME_C%s,
  fragmentName: '%COLLECTION_NAME_C%sItemFragment',
  limit: 5
};

export default withList(options)(withCurrentUser(%COLLECTION_NAME_C%sList));