import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  static bool _busy = false;

  /// 互動式登入並回傳 idToken（給後端驗簽）
  static Future<String?> signInAndGetIdToken() async {
    if (_busy) return null;
    _busy = true;
    try {
      final light =
          await GoogleSignIn.instance.attemptLightweightAuthentication();
      final GoogleSignInAccount account =
          light ?? await GoogleSignIn.instance.authenticate();
      final idToken = ( account.authentication).idToken;
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        log('Google sign-in canceled by user');
        return null;
      }
      log('Google sign-in failed: ${e.code.name}');
      rethrow;
    } finally {
      _busy = false;
    }
  }

  static Future<void> signOut() => GoogleSignIn.instance.signOut();
}
