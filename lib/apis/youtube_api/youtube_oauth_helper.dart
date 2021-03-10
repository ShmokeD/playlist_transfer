import 'package:google_sign_in/google_sign_in.dart';

class GoogleOauth2Helper {
  final GoogleSignIn _helper = GoogleSignIn(
      clientId:
          '2654646304-gaee9dp3npg55abe2nhm1rkfqu93qj94.apps.googleusercontent.com',
      scopes: <String>['https://www.googleapis.com/auth/youtube']);

  Future<bool> login() async {
    await _helper.signIn();
    return _helper.isSignedIn();
  }

  Future<bool> revokeLogin() async {
    return true;
  }

  Future<bool> get isLoggedIn async {
    return _helper.isSignedIn();
  }

  // Future<AccessTokenResponse> get token async {
  //   return await _helper.getTokenFromStorage();
  // }
}
