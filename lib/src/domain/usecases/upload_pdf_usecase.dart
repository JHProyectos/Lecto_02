//lib/src/domain/usecases/upload_pdf_usecase.dart
import '../entities/pdf.dart';
import '../repositories/pdf_repository.dart';

/// Caso de uso para subir un archivo PDF al servidor.
class UploadPdfUseCase {
  final PdfRepository _pdfRepository;

  UploadPdfUseCase(this._pdfRepository);

  /// Sube un archivo PDF al servidor.
  ///
  /// [pdf] es el objeto Pdf que contiene la información del archivo a subir.
  /// Retorna un objeto [Pdf] actualizado con la información del servidor.
  /// Puede lanzar una [PdfUploadException] si ocurre un error durante la subida.
  Future<Pdf> execute(Pdf pdf) async {
    try {
      // Aquí iría la lógica para subir el PDF al servidor
      // Por ahora, solo simularemos la subida
      await Future.delayed(Duration(seconds: 2)); // Simulación de subida
      
      // Guardamos el PDF en el repositorio local
      await _pdfRepository.savePdf(pdf);
      
      return pdf;
    } catch (e) {
      throw PdfUploadException('Error al subir el PDF: $e');
    }
  }
}

/// Excepción específica para errores durante la subida de PDFs.
class PdfUploadException implements Exception {
  final String message;
  PdfUploadException(this.message);

  @override
  String toString() => 'PdfUploadException: $message';
}
