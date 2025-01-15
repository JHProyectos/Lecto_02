//lib/src/services/auth_service.dart
import '../domain/entities/user.dart';

/// Servicio para manejar la autenticación de usuarios.
abstract class AuthService {
  /// Inicia sesión con email y contraseña.
  ///
  /// Retorna un [User] si la autenticación es exitosa.
  /// Puede lanzar una [AuthServiceException] si ocurre un error.
  Future<User> login(String email, String password);

  /// Cierra la sesión del usuario actual.
  ///
  /// Puede lanzar una [AuthServiceException] si ocurre un error.
  Future<void> logout();

  /// Registra un nuevo usuario.
  ///
  /// Retorna el [User] creado si el registro es exitoso.
  /// Puede lanzar una [AuthServiceException] si ocurre un error.
  Future<User> register(String name, String email, String password);

  /// Obtiene el usuario actualmente autenticado.
  ///
  /// Retorna un [User] si hay una sesión activa, null en caso contrario.
  /// Puede lanzar una [AuthServiceException] si ocurre un error.
  Future<User?> getCurrentUser();
}

/// Excepción específica para errores en el servicio de autenticación.
class AuthServiceException implements Exception {
  final String message;
  AuthServiceException(this.message);

  @override
  String toString() => 'AuthServiceException: $message';
}
