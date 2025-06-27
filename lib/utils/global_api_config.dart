// lib/utils/global_api_config.dart

class ApiConfig {
  static const bool useLocalApi = true;

  static String get baseUrl {
    return useLocalApi
        ? 'http://localhost:1880/'
        : 'https://192.168.1.123:1880/';
  }
}
