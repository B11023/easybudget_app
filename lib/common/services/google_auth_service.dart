import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServiceV7 {
  /// 在 App 啟動時或首次使用前呼叫一次
  static Future<void> init() async {
    // 其中 serverClientId 必須是 GCP 建立的「Web client ID」
    await GoogleSignIn.instance.initialize(
      serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
      // 若 iOS/macOS 也需額外指定 clientId，可一併帶入
      // clientId: 'YOUR_IOS_OR_MACOS_CLIENT_ID.apps.googleusercontent.com',
    );
  }

  /// 進行互動式登入；成功後可取 idToken 送給後端驗簽
  static Future<String?> signInAndGetIdToken() async {
    // 輕量化嘗試：若之前已認證，可能可無 UI 取得帳號
    final light = await GoogleSignIn.instance.attemptLightweightAuthentication();

    final GoogleSignInAccount account = light ??
        await GoogleSignIn.instance
            .authenticate(); // 需要時才開啟互動式登入 UI（按鈕觸發）

    final auth = account.authentication; // v7 仍提供 authentication
    return (auth).idToken;         // 只剩 idToken；accessToken 已移除
  }

  static Future<void> signOut() => GoogleSignIn.instance.signOut();
}
