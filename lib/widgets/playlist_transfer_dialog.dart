import 'package:flutter/material.dart';

class PlaylistTransferDialog extends StatefulWidget {
  @override
  _PlaylistTransferDialogState createState() => _PlaylistTransferDialogState();
}

class _PlaylistTransferDialogState extends State<PlaylistTransferDialog> {
  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularProgressIndicator(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Text('Progress: 23%'), Text('PlayName')],
                  )
                ],
              ),
            )
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
