//lib/src/data/datasources/remote/firebase_source.dart
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSource {
  late SharedPreferences _prefs;

  // Método para inicializar SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Validación de inicialización
  void _ensureInitialized() {
    if (_prefs == null) {
      throw Exception(
          'SharedPreferencesSource no está inicializado. Llama a init() primero.');
    }
  }

  // Métodos para manejar cadenas (String)
  Future<bool> setString(String key, String value) async {
    _ensureInitialized();
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    _ensureInitialized();
    return _prefs.getString(key);
  }

  // Métodos para manejar booleanos (bool)
  Future<bool> setBool(String key, bool value) async {
    _ensureInitialized();
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    _ensureInitialized();
    return _prefs.getBool(key);
  }

  // Métodos para manejar enteros (int)
  Future<bool> setInt(String key, int value) async {
    _ensureInitialized();
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    _ensureInitialized();
    return _prefs.getInt(key);
  }

  // Métodos para manejar decimales (double)
  Future<bool> setDouble(String key, double value) async {
    _ensureInitialized();
    return await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    _ensureInitialized();
    return _prefs.getDouble(key);
  }

  // Métodos para manejar listas de cadenas (List<String>)
  Future<bool> setStringList(String key, List<String> value) async {
    _ensureInitialized();
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    _ensureInitialized();
    return _prefs.getStringList(key);
  }

  // Métodos para eliminar un valor o limpiar todo
  Future<bool> remove(String key) async {
    _ensureInitialized();
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    _ensureInitialized();
    return await _prefs.clear();
  }
}

