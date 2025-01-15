//lib/src/data/datasources/remote/firebase_source.dart
import 'dart:async';
import '../entities/audio.dart';

/// Contrato para la gestión de archivos de audio.
abstract class AudioRepository {
  /// Obtiene un stream de audio, ya sea por streaming o desde la caché local.
  ///
  /// [id] es el identificador único del audio.
  /// Retorna un Stream<Audio> que emite actualizaciones sobre el estado del audio.
  /// Puede lanzar una [AudioRepositoryException] si ocurre un error.
  Stream<Audio> getAudioStream(String id);

  /// Obtiene todos los audios almacenados.
  ///
  /// Retorna una lista de [Audio].
  /// Puede lanzar una [AudioRepositoryException] si ocurre un error.
  Future<List<Audio>> getAudios();

  /// Guarda un nuevo audio o actualiza uno existente.
  ///
  /// [audio] es el objeto Audio a guardar o actualizar.
  /// Puede lanzar una [AudioRepositoryException] si ocurre un error.
  Future<void> saveAudio(Audio audio);

  /// Elimina un audio por su ID.
  ///
  /// [id] es el identificador único del audio a eliminar.
  /// Puede lanzar una [AudioRepositoryException] si ocurre un error.
  Future<void> deleteAudio(String id);

  /// Actualiza el progreso de caché de un audio.
  ///
  /// [id] es el identificador único del audio.
  /// [progress] es el progreso de caché (0.0 a 1.0).
  /// Puede lanzar una [AudioRepositoryException] si ocurre un error.
  Future<void> updateCacheProgress(String id, double progress);
}

/// Excepción específica para errores relacionados con el AudioRepository.
class AudioRepositoryException implements Exception {
  final String message;
  AudioRepositoryException(this.message);

  @override
  String toString() => 'AudioRepositoryException: $message';
}
