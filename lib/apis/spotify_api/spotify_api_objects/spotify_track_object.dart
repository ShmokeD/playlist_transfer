class SpotifyTrack {
  SpotifyTrack.fromJson(Map<String, dynamic> json) {
    // print(json);
    // print(json['track']['artists'][0]);
    (json['track']['artists'] as List).forEach((element) {
      // print(element['name']);
      artists.add(element['name']);
    });

    // print(artists);
    //BUG: trackname and id assignments need to be fixed here
    trackName = json['name'] ?? 'TestTrack';
    id = json['id'] ?? 'TestID';

    // print('Spotfy Tracl object');
    // print('id $id');
    // print('trackanme $trackName');
    // print('\n');
    // print('\n');
  }
  List<String> artists = [];
  String trackName;
  String id;
}

// KEY	TYPE
// artists
// The artists who performed the track. Each artist object includes a link in href to more detailed information about the artist.	Array[SimplifiedArtistObject]
// available_markets
// A list of the countries in which the track can be played, identified by their ISO 3166-1 alpha-2 code.	Array[String]
// disc_number
// The disc number (usually 1 unless the album consists of more than one disc).	Integer
// duration_ms
// The track length in milliseconds.	Integer
// explicit
// Whether or not the track has explicit lyrics ( true = yes it does; false = no it does not OR unknown).	Boolean
// external_urls
// External URLs for this track.	ExternalUrlObject
// href
// A link to the Web API endpoint providing full details of the track.	String
// id
// The Spotify ID for the track.	String
// is_local
// Whether or not the track is from a local file.	Boolean
// is_playable
// Part of the response when Track Relinking is applied. If true , the track is playable in the given market. Otherwise false.	Boolean
// linked_from
// Part of the response when Track Relinking is applied and is only part of the response if the track linking, in fact, exists. The requested track has been replaced with a different track. The track in the linked_from object contains information about the originally requested track.	LinkedTrackObject
// name
// The name of the track.	String
// preview_url
// A URL to a 30 second preview (MP3 format) of the track.	String
// restrictions
// Included in the response when a content restriction is applied. See Restriction Object for more details.	TrackRestrictionObject
// track_number
// The number of the track. If an album has several discs, the track number is the number on the specified disc.	Integer
// type
// The object type: “track”.	String
// uri
// The Spotify URI for the track.	String
