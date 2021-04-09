import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_playlist_provider.dart';

class PlaylistTransferDialog extends StatefulWidget {
  @override
  _PlaylistTransferDialogState createState() => _PlaylistTransferDialogState();
}

class _PlaylistTransferDialogState extends State<PlaylistTransferDialog> {
  @override
  Widget build(BuildContext context) {
    SpotifyPlaylists _sPlaylists = Provider.of<SpotifyPlaylists>(context);
    return AlertDialog(
      title: Text(
        'Transferring',
        textAlign: TextAlign.center,
      ),
      // insetPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 150,
        width: 250,
        child: Column(
          children: [
            Text('Please Dont close this app'),
            StreamBuilder<List<dynamic>>(
                initialData: [0, 'initialising'],
                stream: _sPlaylists.toYoutube(context),
                builder: (context, snapshot) {
                  if (snapshot.data[0] == 100)
                    Navigator.of(context).pop('Success');
                  if (snapshot.data[0] > 100) {
                    if (snapshot.data[0] == 429)
                      Navigator.of(context).pop('RateLimit');
                    else
                      Navigator.of(context).pop('Error');
                  }
                  return Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularProgressIndicator(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Progress: ${snapshot.data[0]} %'),
                            Text('${snapshot.data[1]}')
                          ],
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
      // content: SizedBox(
      //   height: 100,
      //   child: Column(
      //     children: [
      //       Text('Please Dont Close this app'),
      //     ],
      //   ),
      // ),
      elevation: 10,
      // titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
