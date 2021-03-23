import 'package:flutter/material.dart';

class PlaylistTransferDialog extends StatefulWidget {
  @override
  _PlaylistTransferDialogState createState() => _PlaylistTransferDialogState();
}

class _PlaylistTransferDialogState extends State<PlaylistTransferDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transferring Playlists'),
      content: SizedBox(
        height: 30,
        width: 50,
        child: Placeholder(),
      ),
      elevation: 10,
      // titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
