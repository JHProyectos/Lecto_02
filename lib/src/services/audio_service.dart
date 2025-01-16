//lib/src/services/audio_service.dart
import 'dart:async';
import '../domain/entities/audio.dart';

/// Servicio para manejar operaciones relacionadas con archivos de audio.
abstract class AudioService {
  /// Reproduce un archivo de audio.
  ///
  /// [audio] es el objeto Audio a reproducir.
  /// Retorna un Stream que emite el progreso de la reproducción (0.0 a 1.0).
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Stream<double> playAudio(Audio audio);

  /// Pausa la reproducción del audio actual.
  ///
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<void> pauseAudio();

  /// Reanuda la reproducción del audio pausado.
  ///
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<void> resumeAudio();

  /// Detiene la reproducción del audio actual.
  ///
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<void> stopAudio();

  /// Obtiene la duración de un archivo de audio.
  ///
  /// [audio] es el objeto Audio del cual se obtendrá la duración.
  /// Retorna la duración en segundos.
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<Duration> getAudioDuration(Audio audio);

  /// Verifica si un archivo de audio está siendo reproducido actualmente.
  ///
  /// Retorna true si hay un audio reproduciéndose, false en caso contrario.
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<bool> isPlaying();

  /// Busca en el audio a una posición específica.
  ///
  /// [position] es la posición en segundos a la que se desea saltar.
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<void> seekTo(Duration position);

  /// Obtiene la posición actual de reproducción.
  ///
  /// Retorna la posición actual en segundos.
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<Duration> getCurrentPosition();

  /// Ajusta el volumen de reproducción.
  ///
  /// [volume] es el nivel de volumen (0.0 a 1.0).
  /// Puede lanzar una [AudioServiceException] si ocurre un error.
  Future<void> setVolume(double volume);
}

/// Excepción específica para errores en el servicio de audio.
class AudioServiceException implements Exception {
  final String message;
  AudioServiceException(this.message);

  @override
  String toString() => 'AudioServiceException: $message';
}
