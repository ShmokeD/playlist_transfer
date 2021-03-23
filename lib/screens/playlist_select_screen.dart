import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/spotify_api/spotify_api_provider.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_playlist_object.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_external_url.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_private_user.dart';

import '../widgets/playlist_selector_widget.dart';
import '../widgets/playlist_transfer_dialog.dart';

class PlaylistSelectScreen extends StatefulWidget {
  static const routeName = '/playlist-select';

  @override
  _PlaylistSelectScreenState createState() => _PlaylistSelectScreenState();
}

class _PlaylistSelectScreenState extends State<PlaylistSelectScreen> {
  void startTransfer() {
    showDialog(context: context, builder: (_) => PlaylistTransferDialog());
  }

  @override
  Widget build(BuildContext context) {
    SpotifyApi _spotifyApi = Provider.of<SpotifyApi>(context);
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: height * 10 / 100,
              child: Center(
                child: Text(
                  'Select Your Playlists',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            FutureBuilder(
                future: _spotifyApi.playlists(),
                builder: (_, AsyncSnapshot<List<SpotifyPlaylist>> snapshot) =>
                    snapshot.hasData
                        ? Column(children: [
                            Container(
                                height: height * 70 / 100,
                                child:
                                    PlaylistSelector(playlists: snapshot.data)),
                            Center(
                                child: TextButton(
                                    child: Text('Continue'),
                                    onPressed: () => startTransfer()))
                          ])
                        : Center(child: LinearProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
