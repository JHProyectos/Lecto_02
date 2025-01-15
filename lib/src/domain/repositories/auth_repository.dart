//lib/src/domain/repositories/auth_repository.dart
import '../entities/user.dart';

/// Contrato para la autenticación de usuarios.
abstract class AuthRepository {
  /// Inicia sesión con email y contraseña.
  ///
  /// Retorna un [User] si la autenticación es exitosa.
  /// Puede lanzar una [AuthException] si las credenciales son inválidas o ocurre un error.
  Future<User> login(String email, String password);

  /// Cierra la sesión del usuario actual.
  ///
  /// Puede lanzar una [AuthException] si ocurre un error durante el proceso.
  Future<void> logout();

  /// Registra un nuevo usuario.
  ///
  /// Retorna el [User] creado si el registro es exitoso.
  /// Puede lanzar una [AuthException] si ocurre un error durante el registro.
  Future<User> register(String name, String email, String password);

  /// Obtiene el usuario actualmente autenticado.
  ///
  /// Retorna un [User] si hay una sesión activa, null en caso contrario.
  /// Puede lanzar una [AuthException] si ocurre un error al obtener la información.
  Future<User?> getCurrentUser();
}

/// Excepción específica para errores relacionados con la autenticación.
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}
