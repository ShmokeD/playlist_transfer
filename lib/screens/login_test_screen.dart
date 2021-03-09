import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/spotify_api/spotify_api_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final SpotifyApi _spotifyApi = Provider.of<SpotifyApi>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Test Screen Debug'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () => _spotifyApi.login().then((_) {
                      print('Completed');
                      setState(() {});
                    }),
                child: const Text('Login to Spotify')),
            ElevatedButton(
                onPressed: () =>
                    _spotifyApi.revokeLogin().then((_) => setState(() {})),
                child: const Text('Log Out of Spotify'))
          ]),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: _spotifyApi.isLoggedIn,
              builder: (_, AsyncSnapshot<bool> snapshot) {
                return snapshot.hasData
                    ? snapshot.data
                        ? const Text('Logged in to Spotify!!')
                        : const Text('Not Logged in to Spotify')
                    : const Text('Waiting for spotify login');
              },
            ),
          )
        ],
      ),
    );
  }
}
