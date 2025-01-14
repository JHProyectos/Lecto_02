import 'package:flutter/material.dart';

class OrientationStyles {
  static double getPadding(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait ? 16.0 : 24.0;
  }

  static double getSpacing(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait ? 16.0 : 20.0;
  }

  static double getLogoSize(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait ? 100.0 : 80.0;
  }

  // Puedes agregar más métodos según sea necesario
}
