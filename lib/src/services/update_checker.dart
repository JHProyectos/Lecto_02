import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lecto_01/src/core/config/app_config.dart'; // Importa AppConfig

/// Clase para verificar actualizaciones disponibles de la aplicación.
class UpdateChecker {
  /// Versión actual de la aplicación.
  /// Ahora se toma de AppConfig para mantener consistencia.
  final String currentVersion = AppConfig.appVersion;

  /// Verifica si hay una actualización disponible.
  ///
  /// Retorna `true` si hay una nueva versión disponible, `false` en caso contrario.
  /// Puede lanzar una excepción si hay un error al contactar el servidor.
  Future<bool> isUpdateAvailable() async {
    try {
      final response = await http.get(Uri.parse(AppConfig.updateCheckEndpoint));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latestVersion = data['latestVersion'];
        return _isNewerVersion(latestVersion, currentVersion);
      } else {
        throw Exception("Error al verificar actualizaciones: ${response.statusCode}");
      }
    } catch (e) {
      print("Error al verificar actualizaciones: $e");
      return false;
    }
  }

  /// Compara dos versiones para determinar si la última es más reciente.
  ///
  /// [latest] es la versión más reciente del servidor.
  /// [current] es la versión actual de la aplicación.
  /// Retorna `true` si [latest] es más reciente que [current].
  bool _isNewerVersion(String latest, String current) {
    List<int> latestParts = latest.split('.').map(int.parse).toList();
    List<int> currentParts = current.split('.').map(int.parse).toList();
    for (int i = 0; i < latestParts.length; i++) {
      if (latestParts[i] > currentParts[i]) return true;
      if (latestParts[i] < currentParts[i]) return false;
    }
    return false;
  }
}
