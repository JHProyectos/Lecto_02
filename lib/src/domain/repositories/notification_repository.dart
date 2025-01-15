//lib/src/domain/repositories/auth_repository.dart
/// Contrato para el manejo de notificaciones.
abstract class NotificationRepository {
  /// Inicializa el sistema de notificaciones.
  ///
  /// Puede lanzar una [NotificationException] si ocurre un error durante la inicialización.
  Future<void> initialize();

  /// Obtiene el token de notificación del dispositivo.
  ///
  /// Retorna el token como String si está disponible, null en caso contrario.
  /// Puede lanzar una [NotificationException] si ocurre un error al obtener el token.
  Future<String?> getToken();

  /// Suscribe al usuario a un tema específico de notificaciones.
  ///
  /// [topic] es el nombre del tema al que se suscribirá.
  /// Puede lanzar una [NotificationException] si ocurre un error durante la suscripción.
  Future<void> subscribeToTopic(String topic);

  /// Cancela la suscripción del usuario a un tema específico de notificaciones.
  ///
  /// [topic] es el nombre del tema del que se cancelará la suscripción.
  /// Puede lanzar una [NotificationException] si ocurre un error durante la cancelación.
  Future<void> unsubscribeFromTopic(String topic);
}

/// Excepción específica para errores relacionados con las notificaciones.
class NotificationException implements Exception {
  final String message;
  NotificationException(this.message);

  @override
  String toString() => 'NotificationException: $message';
}
