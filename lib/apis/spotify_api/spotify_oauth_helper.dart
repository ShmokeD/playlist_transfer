//package imports
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:meta/meta.dart';
import 'package:oauth2_client/oauth2_response.dart'; //required for the @required annotation

//internal imports

// Created my own OAyth client for spotify since the library does not provide one.
class SpotifyOAuth2Client extends OAuth2Client {
  SpotifyOAuth2Client(
      {@required String redirectUri, @required String customUriScheme})
      : super(
          customUriScheme: customUriScheme,
          redirectUri: redirectUri,
          authorizeUrl: 'https://accounts.spotify.com/authorize',
          tokenUrl: 'https://accounts.spotify.com/api/token',
          refreshUrl: 'https://accounts.spotify.com/api/token',
        );
}

//NOTE: the define custom URI for the app is shmoke.spotistats

class OAuthHelper {
  static final SpotifyOAuth2Client _client = SpotifyOAuth2Client(
    customUriScheme: 'shmoke.playtransfer',
    redirectUri: 'shmoke.playtransfer://playtransfer/redirect',
  );

  final OAuth2Helper _helper = OAuth2Helper(
    _client,
    enablePKCE: true,
    clientId: '5813d1d9d95b4369a2bee0c5d231ce2d',
    scopes: <String>[
      'playlist-read-private',
      'user-read-recently-played',
      'user-read-playback-state',
      'user-read-email', //unnecessary scopr for debug
      'user-read-private' //unnecessary scope
    ],
  );

  //code whcih was not ported to the spotify api class and is still passed to this place

  void printDebugInfo() async {
    var scopes = await _helper.scopes;
    print(scopes);

    print(_helper.clientId);
  }

  Future<bool> login() async {
    //Used to login from outside
    final AccessTokenResponse token = await _helper.getToken();
    return token.isValid();
  }

  Future<http.Response> get(String url) async {
    return await _helper.get(url);
  }

  Future<OAuth2Response> revokeLogin() async {
    final OAuth2Response response = await _helper.disconnect();
    return response;
  }

  //debug properties
  Future<AccessTokenResponse> get token async {
    return await _helper.getTokenFromStorage();
  }
}
