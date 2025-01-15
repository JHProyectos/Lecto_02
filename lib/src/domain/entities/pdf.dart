//lib/src/domain/entities/audio.dart
/// Representa un archivo PDF en la aplicación.
class Pdf {
  /// Identificador único del PDF.
  final String id;

  /// Nombre del archivo PDF.
  final String name;

  /// Ruta del archivo PDF en el dispositivo.
  final String path;

  /// Identificador del usuario propietario del PDF.
  final String userId;

  /// Número de páginas del PDF.
  final int pageCount;

  /// Constructor de la clase Pdf.
  ///
  /// Todos los parámetros son requeridos y no pueden ser nulos.
  Pdf({
    required this.id,
    required this.name,
    required this.path,
    required this.userId,
    required this.pageCount,
  });

  /// Crea una copia de este Pdf pero con los campos proporcionados actualizados.
  Pdf copyWith({
    String? id,
    String? name,
    String? path,
    String? userId,
    int? pageCount,
  }) {
    return Pdf(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      userId: userId ?? this.userId,
      pageCount: pageCount ?? this.pageCount,
    );
  }
}
