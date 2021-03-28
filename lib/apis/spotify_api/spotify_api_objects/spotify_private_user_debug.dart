/* Deprecated file, will be removed during cleanup */

class SpotifyPrivateUser {
  SpotifyPrivateUser.fromJson(Map<String, dynamic> json) {
    country = json['country'] ?? 'No Country Found';
    displayName = json['display_name'] ?? 'No Name Provided';
    email = json['email'] ?? 'No Registered email';
    // external_urls = ExternalUrlObject.fromJson(json['external_urls']);
  }
  String country;

  String displayName;
  String email;
  // ExternalUrlObject external_urls;
  // FolllowersObject followers;
  // String href;
  // String id;
  // List<ImageObject> images;
  // String type;
  // String uri;

}



// KEY	TYPE
// email
// The user’s email address, as entered by the user when creating their account. Important! This email address is unverified; there is no proof that it actually belongs to the user. This field is only available when the current user has granted access to the user-read-email scope.	String
// explicit_content
// The user’s explicit content settings. This field is only available when the current user has granted access to the user-read-private scope.	ExplicitContentSettingsObject
// external_urls
// Known external URLs for this user.	ExternalUrlObject
// followers
// Information about the followers of the user.	FollowersObject
// href
// A link to the Web API endpoint for this user.	String
// id
// The Spotify user ID for the user.	String
// images
// The user’s profile image.	Array[ImageObject]
// product
// The user’s Spotify subscription level: “premium”, “free”, etc. (The subscription level “open” can be considered the same as “free”.) This field is only available when the current user has granted access to the user-read-private scope.	String
// type
// The object type: “user”	String  
// uri
// The Spotify URI for the user.	String
