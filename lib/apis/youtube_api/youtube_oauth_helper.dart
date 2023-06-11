import 'package:google_sign_in/google_sign_in.dart';

class GoogleOauth2Helper {
  GoogleSignInAccount? _account;
  final GoogleSignIn _helper = GoogleSignIn(
      // clientId:
      //     '629173728631-clnrfetub3mk6h0ebmd8uci2je1e2uk0.apps.googleusercontent.com',
      scopes: <String>['https://www.googleapis.com/auth/youtube']);

  Future<bool> login() async {
    _account = await _helper.signIn();

    return _helper.isSignedIn();
  }

  Future<bool> revokeLogin() async {
    await _helper.signOut();
    return _helper.isSignedIn();
  }

  Future<bool> get isLoggedIn async {
    return _helper.isSignedIn();
  }

  void getAccount() async {
    _account = await _helper.signInSilently();
  }

  Future<Map<String, String>> get authHeaders async {
    return _account!.authHeaders;
  }
}
