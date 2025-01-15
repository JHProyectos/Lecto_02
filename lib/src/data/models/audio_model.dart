//lib/src/data/models/audio_model.dart
/// Represents an audio file linked to a specific PDF document.
class AudioModel {
  /// Unique identifier of the audio.
  final String id;

  /// Name or title of the audio file.
  final String name;

  /// Path or URL where the audio file is stored.
  final String path;

  /// Identifier of the associated PDF document.
  final String pdfId;

  /// Creates an instance of [AudioModel].
  AudioModel({
    required this.id,
    required this.name,
    required this.path,
    required this.pdfId,
  });

  /// Creates an [AudioModel] instance from a JSON map.
  ///
  /// Throws [FormatException] if required fields are missing or invalid.
  factory AudioModel.fromJson(Map<String, dynamic> json) {
    try {
      return AudioModel(
        id: json['id'] as String,
        name: json['name'] as String,
        path: json['path'] as String,
        pdfId: json['pdfId'] as String,
      );
    } catch (e) {
      throw FormatException('Error parsing AudioModel: $e');
    }
  }

  /// Converts the [AudioModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'pdfId': pdfId,
    };
  }

  /// Creates a copy of the current [AudioModel] with updated values.
  ///
  /// This method is useful for immutability and state updates.
  AudioModel copyWith({
    String? id,
    String? name,
    String? path,
    String? pdfId,
  }) {
    return AudioModel(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      pdfId: pdfId ?? this.pdfId,
    );
  }

  @override
  String toString() {
    return 'AudioModel(id: $id, name: $name, path: $path, pdfId: $pdfId)';
  }
}
