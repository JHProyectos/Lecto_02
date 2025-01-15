//lib/src/services/text_extraction_service.dart
/// Servicio para extraer texto de diferentes fuentes.
abstract class TextExtractionService {
  /// Extrae texto de un archivo PDF.
  ///
  /// [filePath] es la ruta del archivo PDF.
  /// Retorna el texto extraído como String.
  /// Puede lanzar una [TextExtractionException] si ocurre un error.
  Future<String> extractTextFromPdf(String filePath);

  /// Extrae texto de una imagen.
  ///
  /// [filePath] es la ruta de la imagen.
  /// Retorna el texto extraído como String.
  /// Puede lanzar una [TextExtractionException] si ocurre un error.
  Future<String> extractTextFromImage(String filePath);
}

/// Excepción específica para errores en el servicio de extracción de texto.
class TextExtractionException implements Exception {
  final String message;
  TextExtractionException(this.message);

  @override
  String toString() => 'TextExtractionException: $message';
}
