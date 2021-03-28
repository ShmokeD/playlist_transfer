import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './youtube_oauth_helper.dart';

import '../spotify_api/spotify_api_provider.dart';

class YoutubeApi with ChangeNotifier {
  final GoogleOauth2Helper _helper = GoogleOauth2Helper();

  void printPlaylist(BuildContext context) {
    SpotifyApi _spotApi = Provider.of<SpotifyApi>(context);
    // _spotApi.printDebugInfo();
  }
}
