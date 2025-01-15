//lib/src/domain/usecases/extract_text_usecase.dart
import '../entities/pdf.dart';

/// Caso de uso para extraer texto de un PDF.
class ExtractTextUseCase {
  /// Extrae el texto de un archivo PDF.
  ///
  /// [pdf] es el objeto Pdf del cual se extraerá el texto.
  /// Retorna el texto extraído como String.
  /// Puede lanzar una [TextExtractionException] si ocurre un error durante la extracción.
  Future<String> execute(Pdf pdf) async {
    try {
      // Aquí iría la lógica de extracción de texto del PDF
      // Por ahora, simularemos la extracción
      await Future.delayed(Duration(seconds: 2)); // Simulación de proceso
      return 'Texto extraído del PDF ${pdf.name}. Este es un contenido de ejemplo.';
    } catch (e) {
      throw TextExtractionException('Error al extraer texto del PDF: $e');
    }
  }
}

/// Excepción específica para errores durante la extracción de texto de un PDF.
class TextExtractionException implements Exception {
  final String message;
  TextExtractionException(this.message);

  @override
  String toString() => 'TextExtractionException: $message';
}
