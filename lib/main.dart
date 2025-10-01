import 'package:easybudget_app/app.dart';
import 'package:easybudget_app/common/provider/entry_provider.dart';
import 'package:easybudget_app/core/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:easybudget_app/common/config/env_config.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  ApiClient.init();
  await GoogleSignIn.instance.initialize(
    serverClientId: EnvConfig.googleClientId,
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EntryProvider())],
      child: const App(),
    ),
  );
}
