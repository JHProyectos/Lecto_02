//lib/src/core/config/app_config.dart
class AppConfig {
  static const String appName = 'Lecto';
  static const String appVersion = '1.0.0';
  
  // Configuración Freemium/Premium
  static const int maxFreePDFsPerMonth = 3;
  static const int maxFreePagesPerPDF = 10;
  
  // API endpoints
  static const String apiBaseUrl = 'https://api.lecto.com';
  
  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
