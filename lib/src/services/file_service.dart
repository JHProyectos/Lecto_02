//lib/src/services/file_service.dart
import 'dart:io';

/// Servicio para manejar operaciones de archivos.
abstract class FileService {
  /// Lee un archivo y retorna su contenido como bytes.
  ///
  /// [filePath] es la ruta del archivo a leer.
  /// Retorna una lista de bytes con el contenido del archivo.
  /// Puede lanzar una [FileServiceException] si ocurre un error.
  Future<List<int>> readFile(String filePath);

  /// Escribe datos en un archivo.
  ///
  /// [filePath] es la ruta donde se escribirá el archivo.
  /// [data] son los bytes a escribir en el archivo.
  /// Puede lanzar una [FileServiceException] si ocurre un error.
  Future<void> writeFile(String filePath, List<int> data);

  /// Elimina un archivo.
  ///
  /// [filePath] es la ruta del archivo a eliminar.
  /// Puede lanzar una [FileServiceException] si ocurre un error.
  Future<void> deleteFile(String filePath);

  /// Verifica si un archivo existe.
  ///
  /// [filePath] es la ruta del archivo a verificar.
  /// Retorna true si el archivo existe, false en caso contrario.
  /// Puede lanzar una [FileServiceException] si ocurre un error.
  Future<bool> fileExists(String filePath);
}

/// Excepción específica para errores en el servicio de archivos.
class FileServiceException implements Exception {
  final String message;
  FileServiceException(this.message);

  @override
  String toString() => 'FileServiceException: $message';
}
