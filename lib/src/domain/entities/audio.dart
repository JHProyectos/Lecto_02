//lib/src/domain/entities/audio.dart
/// Representa un archivo de audio en la aplicación.
class Audio {
  /// Identificador único del audio.
  final String id;

  /// Nombre del archivo de audio.
  final String name;

  /// URL del archivo de audio en Google Cloud Platform.
  final String gcpUrl;

  /// Ruta del archivo de audio en el dispositivo (si está en caché).
  final String? localPath;

  /// Identificador del PDF asociado a este audio.
  final String pdfId;

  /// Duración del audio en segundos.
  final int duration;

  /// Indica si el audio está siendo transmitido en streaming.
  bool isStreaming;

  /// Estado de caché del audio.
  CacheStatus cacheStatus;

  /// Progreso de la reproducción (0.0 a 1.0).
  double playbackProgress;

  /// Constructor de la clase Audio.
  Audio({
    required this.id,
    required this.name,
    required this.gcpUrl,
    this.localPath,
    required this.pdfId,
    required this.duration,
    this.isStreaming = false,
    this.cacheStatus = CacheStatus.notCached,
    this.playbackProgress = 0.0,
  });

  /// Crea una copia de este Audio pero con los campos proporcionados actualizados.
  Audio copyWith({
    String? id,
    String? name,
    String? gcpUrl,
    String? localPath,
    String? pdfId,
    int? duration,
    bool? isStreaming,
    CacheStatus? cacheStatus,
    double? playbackProgress,
  }) {
    return Audio(
      id: id ?? this.id,
      name: name ?? this.name,
      gcpUrl: gcpUrl ?? this.gcpUrl,
      localPath: localPath ?? this.localPath,
      pdfId: pdfId ?? this.pdfId,
      duration: duration ?? this.duration,
      isStreaming: isStreaming ?? this.isStreaming,
      cacheStatus: cacheStatus ?? this.cacheStatus,
      playbackProgress: playbackProgress ?? this.playbackProgress,
    );
  }
}

/// Representa el estado de caché de un audio.
enum CacheStatus {
  /// El audio no está en caché.
  notCached,

  /// El audio está parcialmente en caché.
  partiallyCached,

  /// El audio está completamente en caché.
  fullyCached,
}
