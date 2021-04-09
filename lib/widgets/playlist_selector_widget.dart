import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_playlist_provider.dart';
import '../apis/spotify_api/spotify_api_objects/spotify_playlist_object.dart';

class PlaylistSelector extends StatefulWidget {
  PlaylistSelector({@required this.playlists});
  final List<SpotifyPlaylist> playlists;

  @override
  _PlaylistSelectorState createState() => _PlaylistSelectorState();
}

//playlists are added to provider immediately upon selection
class _PlaylistSelectorState extends State<PlaylistSelector> {
  @override
  Widget build(BuildContext context) {
    final _spotifyPlaylists = Provider.of<SpotifyPlaylists>(context);
    return ListView.builder(
        itemCount: widget.playlists.length,
        itemBuilder: (_, index) {
          var playlist = widget.playlists[index];
          return ListTile(
            trailing: Checkbox(
                value: _spotifyPlaylists.isPresent(playlist.id),
                onChanged: (bool state) => state
                    ? _spotifyPlaylists.addPlaylist(playlist)
                    : _spotifyPlaylists.removePlaylist(playlist.id)),
            leading: Text(playlist.name),
          );
        });
  }
}
