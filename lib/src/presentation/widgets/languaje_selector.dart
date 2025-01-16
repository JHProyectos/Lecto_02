///lib/src/presentation/widgets/languaje_selector.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/config/app_config.dart';

/// Widget para seleccionar el idioma de la aplicación.
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: context.locale.languageCode,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Theme.of(context).primaryColor),
      underline: Container(
        height: 2,
        color: Theme.of(context).primaryColor,
      ),
      onChanged: (String? newValue) {
        if (newValue != null) {
          context.setLocale(Locale(newValue));
        }
      },
      items: AppConfig.supportedLocales
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(_getLanguageName(value)),
        );
      }).toList(),
    );
  }

  /// Obtiene el nombre del idioma basado en el código de idioma.
  String _getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'es':
        return 'Español';
      case 'en':
        return 'English';
      default:
        return languageCode;
    }
  }
}
