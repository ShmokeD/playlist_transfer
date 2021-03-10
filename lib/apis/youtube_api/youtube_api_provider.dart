import 'package:flutter/foundation.dart';

import './youtube_oauth_helper.dart';

class YoutubeApi with ChangeNotifier {
  final GoogleOauth2Helper _helper = GoogleOauth2Helper();
}
