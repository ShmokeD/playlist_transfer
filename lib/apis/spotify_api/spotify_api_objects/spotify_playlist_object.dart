import 'spotify_external_url.dart';

class SpotifyPlaylist {
  SpotifyPlaylist.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? 'No description';
    // external_urls = json['external_urls'];
    // print(json['external_urls']);
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];

    // print('${description}   ${href}, ${name}');
  }

  String description;
  String external_urls; //returns only a single url so no need for another obj
  String href;
  String id;
  String name;
  String type; //Must be returned 'playlist'
  String uri;
}

// description
// The playlist description. Only returned for modified, verified playlists, otherwise null.	String
// external_urls
// Known external URLs for this playlist.	ExternalUrlObject
// href
// A link to the Web API endpoint providing full details of the playlist.	String
// id
// The Spotify ID for the playlist.	String
// images
// Images for the playlist. The array may be empty or contain up to three images. The images are returned by size in descending order. See Working with Playlists. Note: If returned, the source URL for the image (url) is temporary and will expire in less than a day.	Array[ImageObject]
// name
// The name of the playlist.	String
// owner
// The user who owns the playlist	PublicUserObject
// public
// The playlist’s public/private status: true the playlist is public, false the playlist is private, null the playlist status is not relevant. For more about public/private status, see Working with Playlists	Boolean
// snapshot_id
// The version identifier for the current playlist. Can be supplied in other requests to target a specific playlist version	String
// tracks
// A collection containing a link ( href ) to the Web API endpoint where full details of the playlist’s tracks can be retrieved, along with the total number of tracks in the playlist. Note, a track object may be null. This can happen if a track is no longer available.	PlaylistTracksRefObject
// type
// The object type: “playlist”	String
// uri
// The Spotify URI for the playlist.	String
