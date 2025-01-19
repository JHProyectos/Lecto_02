// lib/src/presentation/pages/settings/settings_page.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/theme/theme_config.dart';
import '../../blocs/auth_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/language_selector.dart';

/// Página de configuración de la aplicación.
///
/// Permite al usuario ajustar varias configuraciones de la aplicación,
/// como el tema, el idioma y gestionar su cuenta.
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr()),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildThemeSection(context),
            const SizedBox(height: 24),
            _buildLanguageSection(context),
            const SizedBox(height: 24),
            _buildAccountSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.theme_section_title'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        DropdownButton<ThemeMode>(
          value: themeProvider.themeMode,
          onChanged: (ThemeMode? newThemeMode) {
            if (newThemeMode != null) {
              themeProvider.setThemeMode(newThemeMode);
            }
          },
          items: [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('settings.theme_system'.tr()),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('settings.theme_light'.tr()),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('settings.theme_dark'.tr()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.language_section_title'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        const LanguageSelector(),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'settings.account_section_title'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return Column(
                children: [
                  Text('settings.logged_in_as'.tr(args: [state.user.name])),
                  const SizedBox(height: 8),
                  CustomButton(
                    text: 'settings.logout_button'.tr(),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                  ),
                  if (!state.user.isPremium) ...[
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'settings.upgrade_to_premium'.tr(),
                      onPressed: () {
                        // TODO: Implement navigation to upgrade page
                      },
                    ),
                  ],
                ],
              );
            } else {
              return CustomButton(
                text: 'settings.login_button'.tr(),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              );
            }
          },
        ),
      ],
    );
  }
}
