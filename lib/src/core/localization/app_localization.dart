// lib/src/core/localization/app_localization.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// Clase que maneja la configuración y gestión de idiomas de la aplicación.
class AppLocalization {
  /// Idiomas soportados por la aplicación
  static const supportedLocales = [
    Locale('es'), // Español (default)
    Locale('en'), // Inglés
  ];

  /// Idioma por defecto
  static const fallbackLocale = Locale('es');

  /// Ruta a los archivos de traducción
  static const path = 'assets/translations';

  /// Inicializa la configuración de localización
  static Future<void> init() async {
    await EasyLocalization.ensureInitialized();
  }

  /// Obtiene una traducción por su clave
  static String translate(
    String key, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    return tr(
      key,
      args: args,
      namedArgs: namedArgs,
      gender: gender,
    );
  }

  /// Cambia el idioma de la aplicación
  static Future<void> setLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  /// Obtiene el idioma actual de la aplicación
  static Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  /// Verifica si el idioma actual es español
  static bool isSpanish(BuildContext context) {
    return getCurrentLocale(context).languageCode == 'es';
  }

  /// Verifica si el idioma actual es inglés
  static bool isEnglish(BuildContext context) {
    return getCurrentLocale(context).languageCode == 'en';
  }
}
