//lib/src/core/errors/error_handler.dart

import 'package:flutter/material.dart';

class ErrorHandler {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static void logError(String error, [StackTrace? stackTrace]) {
    // Aquí puedes implementar tu lógica de logging
    print('Error: $error');
    if (stackTrace != null) {
      print('StackTrace: $stackTrace');
    }
  }

  static String handleException(dynamic exception) {
    // Manejo de excepciones específicas
    if (exception is NetworkException) {
      return 'Error de red. Por favor, verifica tu conexión.';
    } else if (exception is AuthException) {
      return 'Error de autenticación. Por favor, inicia sesión nuevamente.';
    }
    // Manejo de excepción genérica
    return 'Ha ocurrido un error inesperado.';
  }
}

class NetworkException implements Exception {}
class AuthException implements Exception {}
