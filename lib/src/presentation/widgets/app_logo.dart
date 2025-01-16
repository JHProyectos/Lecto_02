import 'package:flutter/material.dart';

/// Widget que muestra el logo de la aplicación.
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
        child: Text(
          'L',
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.6,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
