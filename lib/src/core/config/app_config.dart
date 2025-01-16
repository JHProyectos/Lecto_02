/// Configuración global de la aplicación
class AppConfig {
  /// Nombre de la aplicación
  static const String appName = 'Lecto';

  /// Versión actual de la aplicación
  /// Debe coincidir con la versión en pubspec.yaml y UpdateChecker
  static const String appVersion = '1.0.1';

  // Configuración Freemium/Premium
  static const int maxFreePDFsPerMonth = 3;
  static const int maxFreePagesPerPDF = 10;

  // API endpoints
  static const String apiBaseUrl = 'https://api.lecto.com';
  static const String updateCheckEndpoint = '$apiBaseUrl/version';

  // Actualizaciones
  /// URLs de actualización por plataforma
  static const String androidStoreUrl = 'https://play.google.com/store/apps/details?id=com.lecto';
  static const String iosStoreUrl = 'https://apps.apple.com/app/lecto/id123456789';
  //la url de actualización de la web la comenté por si es necesario realizar una lógica para el caso de que un usuario esté escuchando un audio o conviertiendo un pdf y se lo mande al inicio si se hace un push de una actualización
  //static const String webUpdateUrl = 'https://www.lecto.com';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Configuraciones adicionales
  static const List<String> supportedLocales = ['en', 'es'];
  static const String translationsPath = 'assets/translations';
}
