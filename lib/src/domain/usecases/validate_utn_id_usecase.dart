//lib/src/domain/usecases/validate_utn_id_usecase.dart
/// Caso de uso para validar el ID de UTN.
class ValidateUtnIdUseCase {
  /// Valida el ID de UTN proporcionado.
  ///
  /// [utnId] es el ID de UTN a validar.
  /// Retorna true si el ID es válido, false en caso contrario.
  /// Puede lanzar una [UtnIdValidationException] si ocurre un error durante la validación.
  Future<bool> execute(String utnId) async {
    try {
      // Aquí iría la lógica real de validación del ID de UTN
      // Por ahora, simularemos una validación básica
      await Future.delayed(Duration(seconds: 1)); // Simulación de proceso

      // Ejemplo de validación: el ID debe tener 8 dígitos
      bool isValid = utnId.length == 8 && int.tryParse(utnId) != null;

      return isValid;
    } catch (e) {
      throw UtnIdValidationException('Error al validar el ID de UTN: $e');
    }
  }
}

/// Excepción específica para errores durante la validación del ID de UTN.
class UtnIdValidationException implements Exception {
  final String message;
  UtnIdValidationException(this.message);

  @override
  String toString() => 'UtnIdValidationException: $message';
}
