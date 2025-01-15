//lib/src/domain/entities/user.dart
/// Representa un usuario en la aplicación.
class User {
  /// Identificador único del usuario.
  final String id;

  /// Nombre del usuario.
  final String name;

  /// Correo electrónico del usuario.
  final String email;

  /// Indica si el usuario tiene una suscripción premium.
  final bool isPremium;

  /// Constructor de la clase User.
  ///
  /// Todos los parámetros son requeridos excepto isPremium, que por defecto es false.
  User({
    required this.id,
    required this.name,
    required this.email,
    this.isPremium = false,
  });

  /// Crea una copia de este User pero con los campos proporcionados actualizados.
  User copyWith({
    String? id,
    String? name,
    String? email,
    bool? isPremium,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isPremium: isPremium ?? this.isPremium,
    );
  }
}
