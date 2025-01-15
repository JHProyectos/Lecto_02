//lib/src/domain/usecases/play_audio_usecase.dart
import 'dart:async';
import '../entities/audio.dart';
import '../repositories/audio_repository.dart';

/// Caso de uso para reproducir un archivo de audio.
class PlayAudioUseCase {
  final AudioRepository _audioRepository;
  final ConnectivityService _connectivityService;

  PlayAudioUseCase(this._audioRepository, this._connectivityService);

  /// Reproduce un archivo de audio, manejando streaming y caché.
  ///
  /// [audioId] es el identificador único del audio a reproducir.
  /// Retorna un Stream<Audio> con actualizaciones sobre la reproducción y el estado de caché.
  /// Puede lanzar una [AudioPlaybackException] si ocurre un error durante la reproducción.
  Stream<Audio> execute(String audioId) async* {
    try {
      final hasInternet = await _connectivityService.checkInternetConnection();
      
      await for (final audio in _audioRepository.getAudioStream(audioId)) {
        if (hasInternet && audio.cacheStatus != CacheStatus.fullyCached) {
          yield* _handleStreamingAndCaching(audio);
        } else {
          yield audio;
        }
      }
    } catch (e) {
      throw AudioPlaybackException('Error al reproducir el audio: $e');
    }
  }

  /// Maneja el streaming y el almacenamiento en caché del audio.
  ///
  /// [audio] es el objeto Audio a procesar.
  /// Retorna un Stream<Audio> con actualizaciones sobre el estado del audio.
  Stream<Audio> _handleStreamingAndCaching(Audio audio) async* {
    audio = audio.copyWith(isStreaming: true);
    yield audio;

    try {
      double cacheProgress = 0.0;
      while (cacheProgress < 1.0) {
        await Future.delayed(Duration(milliseconds: 100));
        cacheProgress += 0.01;
        if (cacheProgress > 1.0) cacheProgress = 1.0;

        await _audioRepository.updateCacheProgress(audio.id, cacheProgress);

        audio = audio.copyWith(
          cacheStatus: cacheProgress < 1.0 ? CacheStatus.partiallyCached : CacheStatus.fullyCached,
          playbackProgress: cacheProgress,
        );
        yield audio;
      }
    } catch (e) {
      throw AudioPlaybackException('Error durante el streaming y caché: $e');
    } finally {
      audio = audio.copyWith(isStreaming: false);
      yield audio;
    }
  }
}

/// Excepción específica para errores durante la reproducción de audio.
class AudioPlaybackException implements Exception {
  final String message;
  AudioPlaybackException(this.message);

  @override
  String toString() => 'AudioPlaybackException: $message';
}

/// Servicio para verificar la conectividad a internet.
abstract class ConnectivityService {
  /// Verifica si hay conexión a internet.
  ///
  /// Retorna true si hay conexión, false en caso contrario.
  Future<bool> checkInternetConnection();
}
