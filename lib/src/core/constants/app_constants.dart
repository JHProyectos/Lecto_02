//lib/src/core/constants/app_constants.dart
class AppConstants {
  // Rutas de assets
  static const String logoPath = 'assets/images/logo.png';
  
  // Claves para SharedPreferences
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';
  
  // Claves para mensajes de error (para internacionalización)
  static const String genericErrorKey = 'generic_error';
  static const String networkErrorKey = 'network_error';
  static const String authErrorKey = 'auth_error';
  static const String validationErrorKey = 'validation_error';
  static const String fileUploadErrorKey = 'file_upload_error';
  static const String conversionErrorKey = 'conversion_error';
  
  // Formatos
  static const String dateFormat = 'dd/MM/yyyy';
  
  // Tamaños
  static const double maxFileSizeMB = 10.0;
}
