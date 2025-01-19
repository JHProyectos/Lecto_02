// lib/src/presentation/widgets/language_selector.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/localization/app_localization.dart';

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
      items: [
        DropdownMenuItem(
          value: 'es',
          child: Text('settings.spanish'.tr()), // "Español"
        ),
        DropdownMenuItem(
          value: 'en',
          child: Text('settings.english'.tr()), // "English"
        ),
      ],
      onChanged: (String? languageCode) {
        if (languageCode != null) {
          AppLocalization.setLocale(context, Locale(languageCode));
        }
      },
    );
  }
}
