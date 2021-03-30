import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import './youtube_oauth_helper.dart';

import '../spotify_api/spotify_api_provider.dart';

class YoutubeApi with ChangeNotifier {
  final GoogleOauth2Helper _helper = GoogleOauth2Helper();

  void printPlaylist(BuildContext context) {
    SpotifyApi _spotApi = Provider.of<SpotifyApi>(context);
    // _spotApi.printDebugInfo();
  }

  Future<bool> login() async {
    return await _helper.login(); //passed directly from helper
  }

  Future<bool> revokeLogin() async {
    return await _helper.revokeLogin();
  }

  Future<bool> get isLoggedIn async {
    return _helper.isLoggedIn;
  }

  void getAccount() async {
    _helper.getAccount();
  }

  void printDebug() {
    _helper.printDebug();
  }

  Future<String> search(String searchArg) async {
    Uri uri = Uri.https('www.googleapis.com', '/youtube/v3/search', {
      'part': 'snippet',
      'fields': 'items(id,snippet/title)',
      'type': 'video',
      'q': searchArg,
      'maxResults': '3'
    });
    http.Response resp =
        await http.get(uri, headers: await _helper.authHeaders);
    print(resp.body);
    return (resp.body);
  }
}

/* Refer these sites for documentaion : 
https://developers.google.com/youtube/v3/getting-started
https://developers.google.com/youtube/v3/docs/search/list 
*/
