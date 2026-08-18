enum AppEnvironment { mock, rest }

class AppConfig {
  static AppEnvironment environment = AppEnvironment.mock;

  // Spring Boot REST API base URL
  // For Android Emulator use http://10.0.2.2:8080
  // For Physical Device use your machine local IP or production domain
  static String apiBaseUrl = 'http://10.0.2.2:8080';
  static Duration timeout = const Duration(seconds: 15);
}
