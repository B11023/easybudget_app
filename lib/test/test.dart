import 'package:easybudget_app/core/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easybudget_app/common/config/env_config.dart';
import 'package:easybudget_app/features/login/presentation/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  ApiClient.init();
  await GoogleSignIn.instance.initialize(
    serverClientId: EnvConfig.googleClientId,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 直接給實際首頁（或你也可以先給 SplashPage）
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInPage(),
    );
  }
}
