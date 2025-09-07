import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get googleClientId => dotenv.env['googleClientId'] ?? "";
  static String get api => dotenv.env['api'] ?? "";
}