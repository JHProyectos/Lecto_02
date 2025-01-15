//lib/src/data/models/user_model.dart
/// Modelo que representa un usuario en el sistema.
class UserModel {
  /// Identificador único del usuario.
  final String id;

  /// Nombre del usuario.
  final String name;

  /// Correo electrónico del usuario.
  final String email;

  /// Indica si el usuario tiene acceso premium.
  final bool isPremium;

  /// Constructor constante para instancias inmutables.
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.isPremium = false,
  });

  /// Crea una instancia de [UserModel] a partir de un [Map] en formato JSON.
  /// 
  /// Lanza una excepción si faltan datos obligatorios.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? '', // Fallback en caso de datos faltantes.
      name: json['name'] as String? ?? 'Unknown',
      email: json['email'] as String? ?? 'unknown@example.com',
      isPremium: json['isPremium'] as bool? ?? false,
    );
  }

  /// Convierte esta instancia en un [Map] en formato JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isPremium': isPremium,
    };
  }

  /// Compara dos instancias de [UserModel] por sus propiedades.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserModel) return false;
    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.isPremium == isPremium;
  }

  /// Genera un código hash basado en las propiedades del usuario.
  @override
  int get hashCode {
    return Object.hash(id, name, email, isPremium);
  }

  /// Crea una nueva instancia basada en la actual, con cambios específicos.
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isPremium,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  /// Retorna una representación en texto para depuración.
  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isPremium: $isPremium)';
  }
}
