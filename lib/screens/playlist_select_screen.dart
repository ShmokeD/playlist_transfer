import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/spotify_api/spotify_api_provider.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_playlist_object.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_external_url.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_private_user.dart';

class PlaylistSelectScreen extends StatelessWidget {
  static const routeName = '/playlist-select';
  @override
  Widget build(BuildContext context) {
    SpotifyApi _spotifyApi = Provider.of<SpotifyApi>(context);

    _spotifyApi.playlists().then((SpotifyPlaylist value) {
      print(value.href);
      print(value.uri);
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Select Your Playlists'),
        ),
        body: Placeholder());
  }
}
