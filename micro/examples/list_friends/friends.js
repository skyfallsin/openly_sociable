/**
 * Request for friend information when the page loads.
 */
 function getData() {
   document.getElementById('message').innerHTML = 'Requesting friends...';
   var req = opensocial.newDataRequest();
   req.add(req.newFetchPersonRequest('VIEWER'), 'viewer');
   req.add(req.newFetchPeopleRequest ('VIEWER_FRIENDS'), 'viewerFriends');
   req.send(onLoadFriends);
 };

/**
 * Parses the response to the friend information request and generates
 * html to list the friends along with their display name and picture.
 *
 * @param {Object} dataResponse Friend information that was requested.
 */
 function onLoadFriends(dataResponse) {
   var viewer = dataResponse.get('viewer').getData();
   var html = 'Friends of ' + viewer.getDisplayName(); 
   html += ':<br><ul>';
   var viewerFriends = dataResponse.get('viewerFriends').getData();
   viewerFriends.each(function(person) {
     html += '<li>' + person.getDisplayName() + '</li>';
   });
   html += '</ul>';
   document.getElementById('message').innerHTML = html;
 };
 _IG_RegisterOnloadHandler(getData);