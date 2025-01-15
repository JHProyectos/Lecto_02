//lib/src/services/pdf_service.dart
import '../domain/entities/pdf.dart';

/// Servicio para manejar operaciones relacionadas con archivos PDF.
abstract class PdfService {
  /// Extrae el texto de un archivo PDF.
  ///
  /// [pdf] es el objeto Pdf del cual se extraerá el texto.
  /// Retorna el texto extraído como String.
  /// Puede lanzar una [PdfServiceException] si ocurre un error.
  Future<String> extractText(Pdf pdf);

  /// Valida la estructura de un archivo PDF.
  ///
  /// [pdf] es el objeto Pdf a validar.
  /// Retorna true si el PDF es válido, false en caso contrario.
  /// Puede lanzar una [PdfServiceException] si ocurre un error.
  Future<bool> validatePdf(Pdf pdf);

  /// Obtiene el número de páginas de un PDF.
  ///
  /// [pdf] es el objeto Pdf del cual se obtendrá el número de páginas.
  /// Retorna el número de páginas como int.
  /// Puede lanzar una [PdfServiceException] si ocurre un error.
  Future<int> getPageCount(Pdf pdf);
}

/// Excepción específica para errores en el servicio de PDF.
class PdfServiceException implements Exception {
  final String message;
  PdfServiceException(this.message);

  @override
  String toString() => 'PdfServiceException: $message';
}
