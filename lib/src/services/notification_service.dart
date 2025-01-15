//lib/src/services/notification_service.dart
/// Servicio para manejar las notificaciones de la aplicación.
abstract class NotificationService {
  /// Inicializa el servicio de notificaciones.
  ///
  /// Puede lanzar una [NotificationServiceException] si ocurre un error.
  Future<void> initialize();

  /// Envía una notificación al usuario.
  ///
  /// [title] es el título de la notificación.
  /// [body] es el cuerpo de la notificación.
  /// [data] es un mapa opcional con datos adicionales para la notificación.
  /// Puede lanzar una [NotificationServiceException] si ocurre un error.
  Future<void> sendNotification(String title, String body, {Map<String, dynamic>? data});

  /// Programa una notificación para ser enviada en el futuro.
  ///
  /// [title] es el título de la notificación.
  /// [body] es el cuerpo de la notificación.
  /// [scheduledDate] es la fecha y hora programada para enviar la notificación.
  /// [data] es un mapa opcional con datos adicionales para la notificación.
  /// Puede lanzar una [NotificationServiceException] si ocurre un error.
  Future<void> scheduleNotification(String title, String body, DateTime scheduledDate, {Map<String, dynamic>? data});

  /// Cancela todas las notificaciones programadas.
  ///
  /// Puede lanzar una [NotificationServiceException] si ocurre un error.
  Future<void> cancelAllNotifications();
}

/// Excepción específica para errores en el servicio de notificaciones.
class NotificationServiceException implements Exception {
  final String message;
  NotificationServiceException(this.message);

  @override
  String toString() => 'NotificationServiceException: $message';
}
