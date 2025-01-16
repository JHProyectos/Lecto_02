import 'package:flutter/material.dart';

/// Widget que muestra el logo de la aplicación desde los assets.
class AppLogo extends StatelessWidget {
  /// El tamaño del logo.
  final double size;

  /// Constructor del AppLogo.
  const AppLogo({Key? key, this.size = 100.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: Center(
        child: Image.asset(
          'assets/images/logo_app.png', // Cargar la imagen desde los assets
          width: size * 0.8, // Ajusta el tamaño de la imagen según el tamaño del logo
          height: size * 0.8, // Ajusta el tamaño de la imagen según el tamaño del logo
          fit: BoxFit.contain, // Asegura que la imagen se ajuste al contenedor sin perder la proporción
        ),
      ),
    );
  }
}
