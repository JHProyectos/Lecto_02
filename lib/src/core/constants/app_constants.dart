//lib/src/core/constants/app_constants.dart
class AppConstants {
  // Rutas de assets
  static const String logoPath = 'assets/images/logo.png';
  
  // Claves para SharedPreferences
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';

  // Claves para mensajes de error (para internacionalización)
  static const String genericErrorKey = 'errors.general';
  static const String networkErrorKey = 'errors.network';
  static const String authErrorKey = 'errors.auth';
  static const String validationErrorKey = 'errors.validation';
  static const String fileUploadErrorKey = 'errors.file_upload';
  static const String conversionErrorKey = 'errors.conversion';
  
  // Formatos
  static const String dateFormat = 'dd/MM/yyyy';
  
  // Tamaños
  static const double maxFileSizeMB = 10.0;
}
