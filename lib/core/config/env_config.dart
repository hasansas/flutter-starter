import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get mode => dotenv.env['ENV_MODE'] ?? 'local';
  static String get localBaseUrl => dotenv.env['BASE_API_URL'] ?? '';

  static bool get isProduction => mode.toLowerCase() == 'production';
}
