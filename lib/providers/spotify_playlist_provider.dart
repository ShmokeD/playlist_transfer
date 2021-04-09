import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playlist_transfer/apis/spotify_api/spotify_api_objects/spotify_track_object.dart';
import 'package:provider/provider.dart';

import '../apis/spotify_api/spotify_api_objects/spotify_playlist_object.dart';

import '../apis/youtube_api/youtube_api_provider.dart';

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

  Stream<List<dynamic>> toYoutube(BuildContext context) async* {
    bool errFlag = false;
    List<dynamic> yieldVal = [0, 'Initialising'];
    yield yieldVal;
    int incPlist =
        100 ~/ _playlists.length; //amount to increment per playlist completion
    //~/ division is converted to integer

    YoutubeApi _youtubeApi = Provider.of<YoutubeApi>(context, listen: false);
    for (SpotifyPlaylist sPlaylist in _playlists) {
      if (errFlag) break;
      String pListId = await _youtubeApi.createPlaylist(sPlaylist.name);
      yieldVal[1] = sPlaylist.name;
      yield yieldVal;
      int incTrack = incPlist ~/ sPlaylist.tracks.length;

      for (SpotifyTrack sTrack in sPlaylist.tracks) {
        String vidId = await _youtubeApi
            .search('${sTrack.trackName} ${sTrack.artists.toString()}');

        print('search ${sTrack.trackName} received $vidId');

        int statCode = await _youtubeApi.addVidToPlist(vidId, pListId);
        if (statCode == 429) {
          yield [101, 'RateExceeded'];
          errFlag = true;
          break;
        }
        print('added');
        yieldVal[0] += incTrack;
        yield yieldVal;
      }
    }
    if (!errFlag) yield [100, 'Completed'];
  }

  void removePlaylist(String id) {
    _playlists.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  bool isPresent(String id) {
    return _playlists.any((element) => element.id == id);
  }
}
