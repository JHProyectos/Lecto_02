//lib/src/services/audio_player_service.dart
import 'package:just_audio/just_audio.dart'; // Puedes usar just_audio para reproducir audio
import 'package:path_provider/path_provider.dart'; // Para obtener la ruta de almacenamiento local
import 'dart:io';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// Reproduce el audio dependiendo de si está en caché o si proviene de la URL.
  Future<void> playAudio(PlaybackArguments arguments) async {
    if (arguments.cachedPath != null) {
      // Reproducir desde la caché local
      _playFromLocal(arguments.cachedPath!);
    } else if (arguments.streamUrl != null) {
      // Reproducir desde la URL de streaming
      _playFromStream(arguments.streamUrl!);
    } else {
      throw Exception('No audio available to play');
    }
  }

  /// Reproduce el archivo de audio desde una ruta local.
  void _playFromLocal(String localPath) async {
    try {
      await _audioPlayer.setFilePath(localPath);  // Establece la ruta local del archivo
      await _audioPlayer.play();
      print('Reproduciendo desde la caché: $localPath');
    } catch (e) {
      print('Error al reproducir desde la caché: $e');
    }
  }

  /// Reproduce el archivo de audio desde una URL (streaming).
  void _playFromStream(String url) async {
    try {
      await _audioPlayer.setUrl(url);  // Establece la URL para transmisión en vivo
      await _audioPlayer.play();
      print('Reproduciendo desde la URL: $url');
    } catch (e) {
      print('Error al reproducir desde la URL: $e');
    }
  }

  /// Detiene la reproducción actual.
  Future<void> stop() async {
    await _audioPlayer.stop();
    print('Reproducción detenida');
  }

  /// Pausa la reproducción actual.
  Future<void> pause() async {
    await _audioPlayer.pause();
    print('Reproducción pausada');
  }

  /// Libera los recursos al cerrar el reproductor.
  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
