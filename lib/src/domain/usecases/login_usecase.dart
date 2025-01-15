//lib/src/domain/usecases/login_usecase.dart
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso para el inicio de sesión de usuarios.
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  /// Realiza el inicio de sesión de un usuario.
  ///
  /// [email] es el correo electrónico del usuario.
  /// [password] es la contraseña del usuario.
  /// Retorna un objeto [User] si el inicio de sesión es exitoso.
  /// Puede lanzar una [LoginException] si ocurre un error durante el proceso.
  Future<User> execute(String email, String password) async {
    try {
      return await _authRepository.login(email, password);
    } catch (e) {
      throw LoginException('Error durante el inicio de sesión: $e');
    }
  }
}

/// Excepción específica para errores durante el inicio de sesión.
class LoginException implements Exception {
  final String message;
  LoginException(this.message);

  @override
  String toString() => 'LoginException: $message';
}
