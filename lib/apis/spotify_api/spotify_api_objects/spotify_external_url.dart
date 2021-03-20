class SpotifyExternalUrl {
  SpotifyExternalUrl.fromJson(Map<String, dynamic> json) {
    spotifyUrl = json['spotify'] ?? 'null url returned';
  }

  String spotifyUrl;
}
/* Thats it thats the ExternalUrlObject that spotfy returns */
