import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apis/spotify_api/spotify_api_provider.dart';
import '../apis/youtube_api/youtube_api_provider.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';

import './playlist_select_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget _printYtStatus(YoutubeApi youtubeApi) {
    youtubeApi.getAccount();
    return const Text('Logged in to YouTube');
  }

  @override
  Widget build(BuildContext context) {
    final SpotifyApi _spotifyApi = Provider.of<SpotifyApi>(context);
    final YoutubeApi _youtubeApi = Provider.of<YoutubeApi>(context);
    // _spotifyApi.printDebugInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Test Screen Debug'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
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
          ),
          const Divider(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SignInButton(Buttons.Google, onPressed: () {
                _youtubeApi.login().then((_) => setState(() {}));
                _youtubeApi.getAccount();
              }),
              // ElevatedButton(
              //     onPressed: () =>
              //         _youtubeApi.login().then((_) => setState(() {})),
              //     child: const Text('Login With Youtube')),
              ElevatedButton(
                  onPressed: () =>
                      _youtubeApi.revokeLogin().then((_) => setState(() {})),
                  child: const Text('Logout of YouTube')),
              ElevatedButton(
                  onPressed: _youtubeApi.printDebug,
                  child: const Text('print yt debug'))
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: _youtubeApi.isLoggedIn,
              builder: (_, AsyncSnapshot<bool> snapshot) => snapshot.hasData
                  ? snapshot.data
                      ? _printYtStatus(_youtubeApi)
                      : const Text('Not Logged in to YouTube')
                  : const Text('Waiting for YouTube Login'),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: const Text('Next'),
                onPressed: () => Navigator.of(context)
                    .pushNamed(PlaylistSelectScreen.routeName),
              ),
            ),
          )
        ],
      ),
    );
  }
}
