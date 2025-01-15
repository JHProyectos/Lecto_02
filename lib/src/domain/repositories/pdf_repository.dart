//lib/src/domain/repositories/pdf_repository.dart
import '../entities/pdf.dart';

/// Contrato para la gestión de archivos PDF.
abstract class PdfRepository {
  /// Obtiene todos los PDFs almacenados.
  ///
  /// Retorna una lista de [Pdf].
  /// Puede lanzar una [PdfRepositoryException] si ocurre un error.
  Future<List<Pdf>> getPdfs();

  /// Obtiene un PDF específico por su ID.
  ///
  /// [id] es el identificador único del PDF.
  /// Retorna un [Pdf] si se encuentra, null en caso contrario.
  /// Puede lanzar una [PdfRepositoryException] si ocurre un error.
  Future<Pdf?> getPdf(String id);

  /// Guarda un nuevo PDF o actualiza uno existente.
  ///
  /// [pdf] es el objeto Pdf a guardar o actualizar.
  /// Puede lanzar una [PdfRepositoryException] si ocurre un error.
  Future<void> savePdf(Pdf pdf);

  /// Elimina un PDF por su ID.
  ///
  /// [id] es el identificador único del PDF a eliminar.
  /// Puede lanzar una [PdfRepositoryException] si ocurre un error.
  Future<void> deletePdf(String id);
}

/// Excepción específica para errores relacionados con el PdfRepository.
class PdfRepositoryException implements Exception {
  final String message;
  PdfRepositoryException(this.message);

  @override
  String toString() => 'PdfRepositoryException: $message';
}
