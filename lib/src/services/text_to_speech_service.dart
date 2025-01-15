//lib/src/services/text_to_speech_service.dart
/// Servicio para convertir texto a voz.
abstract class TextToSpeechService {
  /// Convierte texto a voz y guarda el resultado como un archivo de audio.
  ///
  /// [text] es el texto a convertir.
  /// [outputPath] es la ruta donde se guardará el archivo de audio resultante.
  /// [voice] es el identificador de la voz a utilizar (opcional).
  /// [language] es el código del idioma a utilizar (opcional).
  /// Retorna la ruta del archivo de audio generado.
  /// Puede lanzar una [TextToSpeechException] si ocurre un error.
  Future<String> convertTextToSpeech(String text, String outputPath, {String? voice, String? language});

  /// Obtiene una lista de voces disponibles.
  ///
  /// Retorna una lista de identificadores de voces disponibles.
  /// Puede lanzar una [TextToSpeechException] si ocurre un error.
  Future<List<String>> getAvailableVoices();

  /// Obtiene una lista de idiomas soportados.
  ///
  /// Retorna una lista de códigos de idiomas soportados.
  /// Puede lanzar una [TextToSpeechException] si ocurre un error.
  Future<List<String>> getSupportedLanguages();
}

/// Excepción específica para errores en el servicio de texto a voz.
class TextToSpeechException implements Exception {
  final String message;
  TextToSpeechException(this.message);

  @override
  String toString() => 'TextToSpeechException: $message';
}
