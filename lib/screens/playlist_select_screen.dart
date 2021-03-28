import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/spotify_api/spotify_api_provider.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_playlist_object.dart';

import '../widgets/playlist_selector_widget.dart';
import '../widgets/playlist_transfer_dialog.dart';

import '../apis/youtube_api/youtube_api_provider.dart';

import '../providers/spotify_playlist_provider.dart';

class PlaylistSelectScreen extends StatefulWidget {
  static const routeName = '/playlist-select';

  @override
  _PlaylistSelectScreenState createState() => _PlaylistSelectScreenState();
}

class _PlaylistSelectScreenState extends State<PlaylistSelectScreen> {
  void startTransfer(SpotifyPlaylists _playlists, BuildContext context) {
    _playlists.playlists.isEmpty
        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Select a Playlist'),
          ))
        : showDialog(
            context: context, builder: (_) => PlaylistTransferDialog());
  }

  @override
  Widget build(BuildContext context) {
    final SpotifyApi _spotifyApi = Provider.of<SpotifyApi>(context);
    final SpotifyPlaylists _spotifyPlaylists =
        Provider.of<SpotifyPlaylists>(context);

    Provider.of<YoutubeApi>(context).printPlaylist(context);

    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: _spotifyPlaylists.printDebug,), //debug
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
                        ? Container(
                            height: height * 80 / 100,
                            child: Column(children: [
                              Container(
                                  height: height * 70 / 100,
                                  child: PlaylistSelector(
                                      playlists: snapshot.data)),
                              Expanded(
                                  child: TextButton(
                                      child: Text('Continue'),
                                      onPressed: () => startTransfer(
                                          _spotifyPlaylists, context)))
                            ]),
                          )
                        : Center(child: LinearProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
