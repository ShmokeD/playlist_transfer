class SpotifyExternalUrl {
  SpotifyExternalUrl.fromJson(Map<String, dynamic> json) {
    spotifyUrl = json['spotify'] ?? 'null url returned';
  }

  String spotifyUrl = 'null';
}
/* Thats it thats the ExternalUrlObject that spotfy returns */
