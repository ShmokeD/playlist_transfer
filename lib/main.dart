import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './apis/spotify_api/spotify_api_provider.dart';
import './providers/spotify_playlist_provider.dart';

import './apis/youtube_api/youtube_api_provider.dart';

import './screens/login_test_screen.dart';
import './screens/playlist_select_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SpotifyApi>(
          create: (_) => SpotifyApi(),
        ),
        ChangeNotifierProvider<SpotifyPlaylists>(
          create: (_) => SpotifyPlaylists(),
        ),
        ChangeNotifierProvider<YoutubeApi>(
          create: (_) => YoutubeApi(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          PlaylistSelectScreen.routeName: (ctx) => PlaylistSelectScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen()
        },
      ),
    );
  }
}
