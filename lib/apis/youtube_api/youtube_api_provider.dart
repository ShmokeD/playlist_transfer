import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import './youtube_oauth_helper.dart';

import '../spotify_api/spotify_api_provider.dart';

class YoutubeApi with ChangeNotifier {
  final GoogleOauth2Helper _helper = GoogleOauth2Helper();

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

  Future<String> createPlaylist(String title) async {
    final Uri uri = Uri.https('www.googleapis.com', '/youtube/v3/playlists', {
      'part': ['snippet', 'status'],
      'fields': 'id'
    });
    final Map<String, dynamic> body = {
      'snippet': {'title': title},
      'status': {'privacyStatus': 'private'},
    };
    http.Response _resp = await http.post(uri,
        body: jsonEncode(body), headers: await _helper.authHeaders);
    return jsonDecode(_resp.body)['id'];
  }

  Future<int> addVidToPlist(String vidId, String pListId) async {
    final Uri uri = Uri.https(
        'www.googleapis.com', '/youtube/v3/playlistItems', {'part': 'snippet'});
    Map<String, dynamic> body = {
      'snippet': {
        'playlistId': pListId,
        'resourceId': {'kind': 'youtube#video', 'videoId': vidId}
      }
    };
    http.Response _resp = await http.post(uri,
        body: jsonEncode(body), headers: await _helper.authHeaders);
    return _resp.statusCode;
  }

  Future<String> search(String searchArg) async {
    Uri uri = Uri.https('www.googleapis.com', '/youtube/v3/search', {
      'part': 'snippet',
      'fields': 'items(id)',
      'type': 'video',
      'q': searchArg,
      'maxResults': '1'
    });
    http.Response resp =
        await http.get(uri, headers: await _helper.authHeaders);
    return (jsonDecode(resp.body)['items'][0]['id']['videoId']);
  }
}

/* Refer these sites for documentaion : 
https://developers.google.com/youtube/v3/getting-started
https://developers.google.com/youtube/v3/docs/search/list 
*/
