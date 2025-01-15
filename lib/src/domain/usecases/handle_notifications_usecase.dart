//lib/src/domain/usecases/handle_notifications_usecase.dart
import '../repositories/notification_repository.dart';

/// Caso de uso para manejar notificaciones.
class HandleNotificationsUseCase {
  final NotificationRepository _notificationRepository;

  HandleNotificationsUseCase(this._notificationRepository);

  /// Inicializa el sistema de notificaciones y configura los manejadores.
  ///
  /// Puede lanzar una [NotificationHandlingException] si ocurre un error durante la inicialización.
  Future<void> initialize() async {
    try {
      await _notificationRepository.initialize();
      // Aquí se podrían configurar manejadores adicionales para diferentes tipos de notificaciones
    } catch (e) {
      throw NotificationHandlingException('Error al inicializar las notificaciones: $e');
    }
  }

  /// Obtiene el token de notificación del dispositivo.
  ///
  /// Retorna el token como String si está disponible, null en caso contrario.
  /// Puede lanzar una [NotificationHandlingException] si ocurre un error al obtener el token.
  Future<String?> getToken() async {
    try {
      return await _notificationRepository.getToken();
    } catch (e) {
      throw NotificationHandlingException('Error al obtener el token de notificación: $e');
    }
  }

  /// Suscribe al usuario a un tema específico de notificaciones.
  ///
  /// [topic] es el nombre del tema al que se suscribirá.
  /// Puede lanzar una [NotificationHandlingException] si ocurre un error durante la suscripción.
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _notificationRepository.subscribeToTopic(topic);
    } catch (e) {
      throw NotificationHandlingException('Error al suscribirse al tema $topic: $e');
    }
  }

  /// Cancela la suscripción del usuario a un tema específico de notificaciones.
  ///
  /// [topic] es el nombre del tema del que se cancelará la suscripción.
  /// Puede lanzar una [NotificationHandlingException] si ocurre un error durante la cancelación.
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _notificationRepository.unsubscribeFromTopic(topic);
    } catch (e) {
      throw NotificationHandlingException('Error al cancelar la suscripción al tema $topic: $e');
    }
  }
}

/// Excepción específica para errores relacionados con el manejo de notificaciones.
class NotificationHandlingException implements Exception {
  final String message;
  NotificationHandlingException(this.message);

  @override
  String toString() => 'NotificationHandlingException: $message';
}
