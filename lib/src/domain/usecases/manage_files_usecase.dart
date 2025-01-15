//lib/src/domain/usecases/manage_files_usecase.dart
import '../entities/pdf.dart';
import '../entities/audio.dart';
import '../repositories/pdf_repository.dart';
import '../repositories/audio_repository.dart';

/// Caso de uso para gestionar archivos en el dispositivo.
class ManageFilesUseCase {
  final PdfRepository _pdfRepository;
  final AudioRepository _audioRepository;

  ManageFilesUseCase(this._pdfRepository, this._audioRepository);

  /// Obtiene todos los archivos PDF almacenados.
  ///
  /// Retorna una lista de [Pdf].
  /// Puede lanzar una [FileManagementException] si ocurre un error.
  Future<List<Pdf>> getAllPdfs() async {
    try {
      return await _pdfRepository.getPdfs();
    } catch (e) {
      throw FileManagementException('Error al obtener los archivos PDF: $e');
    }
  }

  /// Obtiene todos los archivos de audio almacenados.
  ///
  /// Retorna una lista de [Audio].
  /// Puede lanzar una [FileManagementException] si ocurre un error.
  Future<List<Audio>> getAllAudios() async {
    try {
      return await _audioRepository.getAudios();
    } catch (e) {
      throw FileManagementException('Error al obtener los archivos de audio: $e');
    }
  }

  /// Elimina un archivo PDF.
  ///
  /// [pdfId] es el identificador único del PDF a eliminar.
  /// Puede lanzar una [FileManagementException] si ocurre un error.
  Future<void> deletePdf(String pdfId) async {
    try {
      await _pdfRepository.deletePdf(pdfId);
    } catch (e) {
      throw FileManagementException('Error al eliminar el archivo PDF: $e');
    }
  }

  /// Elimina un archivo de audio.
  ///
  /// [audioId] es el identificador único del audio a eliminar.
  /// Puede lanzar una [FileManagementException] si ocurre un error.
  Future<void> deleteAudio(String audioId) async {
    try {
      await _audioRepository.deleteAudio(audioId);
    } catch (e) {
      throw FileManagementException('Error al eliminar el archivo de audio: $e');
    }
  }
}

/// Excepción específica para errores durante la gestión de archivos.
class FileManagementException implements Exception {
  final String message;
  FileManagementException(this.message);

  @override
  String toString() => 'FileManagementException: $message';
}
