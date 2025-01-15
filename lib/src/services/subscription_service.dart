// lib/src/services/subscription_service.dart
import '../domain/entities/user.dart';

/// Servicio para manejar las suscripciones de los usuarios.
abstract class SubscriptionService {
  /// Obtiene el estado de suscripción actual del usuario.
  ///
  /// [user] es el usuario del cual se quiere obtener el estado de suscripción.
  /// Retorna true si el usuario tiene una suscripción activa, false en caso contrario.
  /// Puede lanzar una [SubscriptionServiceException] si ocurre un error.
  Future<bool> isSubscriptionActive(User user);

  /// Activa una suscripción para el usuario.
  ///
  /// [user] es el usuario para el cual se activará la suscripción.
  /// [planId] es el identificador del plan de suscripción.
  /// Puede lanzar una [SubscriptionServiceException] si ocurre un error.
  Future<void> activateSubscription(User user, String planId);

  /// Cancela la suscripción activa del usuario.
  ///
  /// [user] es el usuario cuya suscripción se cancelará.
  /// Puede lanzar una [SubscriptionServiceException] si ocurre un error.
  Future<void> cancelSubscription(User user);
}

/// Excepción específica para errores en el servicio de suscripción.
class SubscriptionServiceException implements Exception {
  final String message;
  SubscriptionServiceException(this.message);

  @override
  String toString() => 'SubscriptionServiceException: $message';
}
