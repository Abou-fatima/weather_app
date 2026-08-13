import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  static String get apiKey {
    if (dotenv.isInitialized) {
      return dotenv.env['OPENWEATHER_API_KEY'] ??
          const String.fromEnvironment(
            'OPENWEATHER_API_KEY',
            defaultValue: 'YOUR_API_KEY_HERE',
          );
    }

    return const String.fromEnvironment(
      'OPENWEATHER_API_KEY',
      defaultValue: 'YOUR_API_KEY_HERE',
    );
  }

  static const String baseImageUrl = 'https://openweathermap.org/img/wn';
  static const String hiveBoxName = 'weatherBox';
  static const String hiveUserBox = 'userBox';

  static const Duration cacheDuration = Duration(minutes: 30);
  static const Duration timeoutDuration = Duration(seconds: 30);
}
