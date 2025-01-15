//lib/src/data/models/pdf_model.dart
/// Represents a PDF file associated with a specific user.
class PdfModel {
  /// Unique identifier of the PDF.
  final String id;

  /// Name or title of the PDF file.
  final String name;

  /// Path or URL where the PDF file is stored.
  final String path;

  /// Identifier of the associated user.
  final String userId;

  /// Creates an instance of [PdfModel].
  PdfModel({
    required this.id,
    required this.name,
    required this.path,
    required this.userId,
  });

  /// Creates a [PdfModel] instance from a JSON map.
  ///
  /// Throws [FormatException] if required fields are missing or invalid.
  factory PdfModel.fromJson(Map<String, dynamic> json) {
    try {
      return PdfModel(
        id: json['id'] as String,
        name: json['name'] as String,
        path: json['path'] as String,
        userId: json['userId'] as String,
      );
    } catch (e) {
      throw FormatException('Error parsing PdfModel: $e');
    }
  }

  /// Converts the [PdfModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'userId': userId,
    };
  }

  /// Creates a copy of the current [PdfModel] with updated values.
  ///
  /// This method is useful for immutability and state updates.
  PdfModel copyWith({
    String? id,
    String? name,
    String? path,
    String? userId,
  }) {
    return PdfModel(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'PdfModel(id: $id, name: $name, path: $path, userId: $userId)';
  }
}
