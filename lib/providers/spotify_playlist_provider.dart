import 'package:flutter/foundation.dart';

import '../apis/spotify_api/spotify_api_objects/spotify_playlist_object.dart';

class SpotifyPlaylists extends ChangeNotifier {
  List<SpotifyPlaylist> _playlists = [];

  List<SpotifyPlaylist> get playlists {
    return [..._playlists];
  }

  void addPlaylist(SpotifyPlaylist playlist) {
    _playlists.add(playlist);
    _playlists.toSet().toList(); //removes doubles
    // print(playlist.tracks[0].artists);

    notifyListeners();
  }

  void removePlaylist(String id) {
    _playlists.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  bool isPresent(String id) {
    return _playlists.any((element) => element.id == id);
  }

  void printDebug() {
    _playlists.forEach((element) {
      print(element.name);
      print(element.tracks[0].artists);
    });
  }
}
