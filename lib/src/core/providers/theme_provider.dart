// lib/src/core/providers/theme_provider.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void setSystemMode() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  ThemeData get currentThemeData => isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
}
