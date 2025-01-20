// lib/src/presentation/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// Un botón personalizado que se puede utilizar en toda la aplicación.
class CustomButton extends StatelessWidget {
  /// La clave de traducción para el texto que se mostrará en el botón.
  final String textKey;

  /// La función que se ejecutará cuando se presione el botón.
  final VoidCallback onPressed;

  /// El color de fondo del botón.
  final Color? backgroundColor;

  /// El color del texto del botón.
  final Color? textColor;

  /// Indica si el botón está habilitado o no.
  final bool isEnabled;

  /// Constructor del CustomButton.
  const CustomButton({
    Key? key,
    required this.textKey,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: textColor ?? Colors.white,
        disabledBackgroundColor: Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        textKey.tr(),
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
