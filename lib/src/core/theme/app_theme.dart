// lib/src/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Personaliza más el tema claro aquí
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Personaliza más el tema oscuro aquí
  );

  // Puedes agregar más métodos o getters para estilos específicos
  static TextStyle get headlineStyle => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get bodyStyle => const TextStyle(
    fontSize: 16,
  );

  // Añade más estilos según sea necesario
}
