//lib/src/shared/models/playback_screen_arguments.dart
/// El modelo de `PlaybackArguments` representa los argumentos necesarios
/// para reproducir un archivo de audio, incluyendo la URL de transmisión y la ruta de caché.
class PlaybackArguments {
  final String audioId;
  final String audioName;
  final String? streamUrl;  // URL del audio para transmisión desde la nube
  final String? cachedPath;  // Ruta local para reproducción sin conexión

  /// Constructor del modelo `PlaybackArguments`, requiere los detalles básicos
  /// del audio y las rutas (de la URL o de la caché).
  PlaybackArguments({
    required this.audioId,
    required this.audioName,
    this.streamUrl,  // Puede ser nula si se reproduce desde la caché
    this.cachedPath,  // Puede ser nula si no hay archivo local disponible
  });

  /// Método estático que crea un `PlaybackArguments` a partir de un `AudioModel`,
  /// eligiendo la fuente (caché o streaming) según la conectividad.
  static Future<PlaybackArguments> fromAudioModel(AudioModel audioModel) async {
    final bool isConnected = await AudioModel.isConnected();  // Verifica si hay conexión

    // Si hay conexión, usa la URL de transmisión, sino, usa la caché
    if (isConnected) {
      return PlaybackArguments(
        audioId: audioModel.id,
        audioName: audioModel.name,
        streamUrl: audioModel.streamUrl,
        cachedPath: null,  // No se necesita caché si se transmite
      );
    } else {
      return PlaybackArguments(
        audioId: audioModel.id,
        audioName: audioModel.name,
        streamUrl: null,  // No se necesita transmisión si usamos la caché
        cachedPath: audioModel.cachedPath,  // Se usa la ruta local si está disponible
      );
    }
  }
}
