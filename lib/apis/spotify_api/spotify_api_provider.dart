import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_response.dart';

import 'spotify_oauth_helper.dart';
import './spotify_api_objects/spotify_external_url.dart';
import './spotify_api_objects/spotify_playlist_object.dart';
import './spotify_api_objects/spotify_private_user.dart';

// This Wrapper around helper is created to help in organize requests.
class SpotifyApi with ChangeNotifier {
  final OAuthHelper _helper = OAuthHelper();

  Future<bool> get isLoggedIn async {
    return (await _helper.token) != null;
  }

  Future<bool> login() async {
    final bool _response = await _helper.login().catchError((Object error) {
      print('Error!!');
      return false;
    });
    return _response;
  }

  Future<SpotifyPrivateUser> getUserProfile() async {
    final http.Response _resp =
        await _helper.get('https://api.spotify.com/v1/me');
    return SpotifyPrivateUser.fromJson(jsonDecode(_resp.body));
  }

  Stream<String> currentlyPlaying() async* {
    while (true) {
      final http.Response _resp =
          await _helper.get('https://api.spotify.com/v1/me/player');
      await Future<String>.delayed(const Duration(
          seconds:
              5)); //specified type because flutter whines and throws errors and i cant be bothered really
      yield _resp.body.toString();
    }
  }

  Future<List<SpotifyPlaylist>> playlists() async {
    final http.Response _resp =
        await _helper.get('https://api.spotify.com/v1/me/playlists');
    // print('Actual Response: ${_resp.body}');
    var itemList = (jsonDecode(_resp.body)["items"] as List);
    List<SpotifyPlaylist> playLists =
        itemList.map((e) => SpotifyPlaylist.fromJson(e)).toList();
    print('Converted ${playLists}');

    return [...playLists];
  }

  void printDebugInfo() async {
    _helper.printDebugInfo();
  }

  Future<OAuth2Response> revokeLogin() => _helper.revokeLogin();
}
