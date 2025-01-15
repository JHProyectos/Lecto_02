//lib/src/domain/entities/audio.dart
/// Representa un archivo de audio en la aplicación.
class Audio {
  /// Identificador único del audio.
  final String id;

  /// Nombre del archivo de audio.
  final String name;

  /// Ruta del archivo de audio en el dispositivo.
  final String path;

  /// Identificador del PDF asociado a este audio.
  final String pdfId;

  /// Duración del audio en segundos.
  final int duration;

  /// Constructor de la clase Audio.
  ///
  /// Todos los parámetros son requeridos y no pueden ser nulos.
  Audio({
    required this.id,
    required this.name,
    required this.path,
    required this.pdfId,
    required this.duration,
  });

  /// Crea una copia de este Audio pero con los campos proporcionados actualizados.
  Audio copyWith({
    String? id,
    String? name,
    String? path,
    String? pdfId,
    int? duration,
  }) {
    return Audio(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      pdfId: pdfId ?? this.pdfId,
      duration: duration ?? this.duration,
    );
  }
}
