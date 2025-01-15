//lib/src/domain/usecases/convert_to_audio_usecase.dart
import '../entities/audio.dart';
import '../entities/pdf.dart';
import '../repositories/audio_repository.dart';

/// Caso de uso para convertir texto a audio.
class ConvertToAudioUseCase {
  final AudioRepository _audioRepository;

  ConvertToAudioUseCase(this._audioRepository);

  /// Convierte el texto extraído de un PDF a audio.
  ///
  /// [pdf] es el objeto Pdf del cual se extrajo el texto.
  /// [text] es el texto extraído del PDF.
  /// Retorna un objeto [Audio] con la información del audio generado.
  /// Puede lanzar una [ConversionException] si ocurre un error durante la conversión.
  Future<Audio> execute(Pdf pdf, String text) async {
    try {
      // Aquí iría la lógica de conversión de texto a audio
      // Por ahora, simularemos la creación de un audio
      final audio = Audio(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: '${pdf.name}_audio',
        path: '/path/to/audio/${pdf.name}_audio.mp3',
        pdfId: pdf.id,
        duration: text.length ~/ 20, // Simulación simple de duración
      );

      await _audioRepository.saveAudio(audio);
      return audio;
    } catch (e) {
      throw ConversionException('Error al convertir texto a audio: $e');
    }
  }
}

/// Excepción específica para errores durante la conversión de texto a audio.
class ConversionException implements Exception {
  final String message;
  ConversionException(this.message);

  @override
  String toString() => 'ConversionException: $message';
}
