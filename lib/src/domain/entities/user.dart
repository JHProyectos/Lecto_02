//lib/src/domain/entities/user.dart
/// Enumeración de los tipos de usuario.
enum UserType {
  free,       // Usuario gratuito
  premium,    // Usuario premium
  developer,  // Usuario desarrollador
  tester,     // Usuario tester
  admin,      // Usuario administrador (nuevo)
  guest,      // Usuario invitado (nuevo)
}

/// Entidad que representa a un usuario en la aplicación.
class User {
  /// Identificador único del usuario.
  final String id;

  /// Identificador único de la Universidad Tecnológica Nacional (UTN).
  final String utnId;

  /// Nombre del usuario.
  final String name;

  /// Correo electrónico del usuario.
  final String email;

  /// Tipo de usuario.
  final UserType userType;

  /// Indica si el usuario tiene una suscripción premium.
  final bool isPremium;

  /// Constructor de la clase User.
  User({
    required this.id,
    required this.utnId,
    required this.name,
    required this.email,
    required this.userType,
    this.isPremium = false,
  });

  /// Verifica si el usuario es premium.
  bool get isPremiumUser => userType == UserType.premium;

  /// Verifica si el usuario es desarrollador.
  bool get isDeveloper => userType == UserType.developer;

  /// Verifica si el usuario es tester.
  bool get isTester => userType == UserType.tester;

  /// Verifica si el usuario es administrador.
  bool get isAdmin => userType == UserType.admin;

  /// Verifica si el usuario es invitado.
  bool get isGuest => userType == UserType.guest;

  /// Crea una copia de este User pero con los campos proporcionados actualizados.
  User copyWith({
    String? id,
    String? utnId,
    String? name,
    String? email,
    UserType? userType,
    bool? isPremium,
  }) {
    return User(
      id: id ?? this.id,
      utnId: utnId ?? this.utnId,
      name: name ?? this.name,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      isPremium: isPremium ?? this.isPremium,
    );
  }
}
