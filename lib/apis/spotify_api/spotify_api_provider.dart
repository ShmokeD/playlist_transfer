import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_response.dart';

import './oauth_helper_provider.dart';
import './spotify_api_objects/spotify_private_user.dart';

// This Wrapper around helper is created to help in organize requests.
class SpotifyApi with ChangeNotifier {
  final OAuthHelper _helper = OAuthHelper();

  Future<bool> get isLoggedIn async {
    return (await _helper.token) != null ? true : false;
  }

  Future<AccessTokenResponse> login() {
    return _helper.login();
  }

  Future<PrivateUserObject> getUserProfile() async {
    final http.Response resp =
        await _helper.get('https://api.spotify.com/v1/me');
    return PrivateUserObject.fromJson(jsonDecode(resp.body));
  }

  Stream<String> currentlyPlaying() async* {
    while (true) {
      final http.Response resp =
          await _helper.get('https://api.spotify.com/v1/me/player');
      await Future<String>.delayed(const Duration(
          seconds:
              5)); //specified type because flutter whines and throws errors and i cant be bothered really
      yield resp.body.toString();
    }
  }

  Future<OAuth2Response> revokeLogin() => _helper.revokeLogin();
}
