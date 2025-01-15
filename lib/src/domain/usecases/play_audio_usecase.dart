//lib/src/domain/usecases/play_audio_usecase.dart
import '../entities/audio.dart';
import '../repositories/audio_repository.dart';

/// Caso de uso para reproducir un archivo de audio.
class PlayAudioUseCase {
  final AudioRepository _audioRepository;

  PlayAudioUseCase(this._audioRepository);

  /// Reproduce un archivo de audio.
  ///
  /// [audioId] es el identificador único del audio a reproducir.
  /// Retorna un objeto [Audio] con la información del audio reproducido.
  /// Puede lanzar una [AudioPlaybackException] si ocurre un error durante la reproducción.
  Future<Audio> execute(String audioId) async {
    try {
      final audio = await _audioRepository.getAudio(audioId);
      if (audio == null) {
        throw AudioPlaybackException('Audio no encontrado');
      }
      
      // Aquí iría la lógica para reproducir el audio
      // Por ahora, solo simularemos la reproducción
      print('Reproduciendo audio: ${audio.name}');
      
      return audio;
    } catch (e) {
      throw AudioPlaybackException('Error al reproducir el audio: $e');
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
