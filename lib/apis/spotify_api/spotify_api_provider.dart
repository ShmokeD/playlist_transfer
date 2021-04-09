import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:oauth2_client/oauth2_response.dart';

import './spotify_oauth_helper.dart';
import './spotify_api_objects/spotify_playlist_object.dart';
import './spotify_api_objects/spotify_private_user_debug.dart';
import './spotify_api_objects/spotify_track_object.dart';

// This Wrapper around helper is created to help in organize requests.
class SpotifyApi with ChangeNotifier {
  final OAuthHelper _helper = OAuthHelper();

  Future<bool> get isLoggedIn async {
    return (await _helper.token) != null;
  }

  Future<bool> login() async {
    final bool _response = await _helper.login().catchError((Object error) {
      return false;
    });
    return _response;
  }

  Future<List<SpotifyPlaylist>> playlists() async {
    final http.Response _resp =
        await _helper.get('https://api.spotify.com/v1/me/playlists');
    var itemList = (jsonDecode(_resp.body)["items"] as List);

    /* Requesting track from inside playlist object will require passing
    provider to object and to prevent that, tracks are also requested here 
    and passed to the spotify object .
    Although it makes the loading a little longer, it saves a ton of headache for later :)
    */

    List<SpotifyPlaylist> playLists = [];

    for (var element in itemList) {
      var tracks = await tracklist(element['id']);
      SpotifyPlaylist playlist = SpotifyPlaylist.fromJson(element, tracks);
      playLists.add(playlist);
    }

    return playLists;
  }

  Future<List<SpotifyTrack>> tracklist(String playlistId) async {
    final requestUrl =
        Uri.parse('https://api.spotify.com/v1/playlists/' + playlistId);
    final http.Response _resp = await _helper.get(requestUrl.toString());
    var trackList = ((jsonDecode(_resp.body)['tracks']['items'] as List));

    List<SpotifyTrack> tracks =
        trackList.map((e) => SpotifyTrack.fromJson(e)).toList();

    return [...tracks];
  }

  

  Future<OAuth2Response> revokeLogin() => _helper.revokeLogin();
}
