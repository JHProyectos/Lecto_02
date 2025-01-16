// lib/src/presentation/pages/settings/settings_page.dart

// Widgets y funcionalidades básicas de Flutter
import 'package:flutter/material.dart';

// Localización
import 'package:easy_localization/easy_localization.dart';

// Gestión de estado
import 'package:flutter_bloc/flutter_bloc.dart';

// Gestión de temas
import '../../../core/providers/theme_provider.dart';
import '../../../core/theme/theme_config.dart';

// Blocs
import '../../blocs/auth_bloc.dart';

// Widgets personalizados
import '../../widgets/custom_button.dart';
import '../../widgets/language_selector.dart';

/// Página de configuración de la aplicación.
///
/// Permite al usuario ajustar varias configuraciones de la aplicación,
/// como el tema, el idioma y gestionar su cuenta.
class SettingsPage extends StatelessWidget {
  /// Constructor de SettingsPage.
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings_title'.tr()), // "Configuración"
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

  /// Construye la sección de configuración del tema.
  Widget _buildThemeSection(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'theme_section_title'.tr(), // "Tema de la aplicación"
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
              child: Text('theme_system'.tr()), // "Sistema"
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('theme_light'.tr()), // "Claro"
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('theme_dark'.tr()), // "Oscuro"
            ),
          ],
        ),
      ],
    );
  }

  /// Construye la sección de configuración del idioma.
  Widget _buildLanguageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'language_section_title'.tr(), // "Idioma"
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        const LanguageSelector(),
      ],
    );
  }

  /// Construye la sección de gestión de cuenta.
  Widget _buildAccountSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'account_section_title'.tr(), // "Cuenta"
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 8),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return Column(
                children: [
                  Text('logged_in_as'.tr(args: [state.user.name])), // "Conectado como: {name}"
                  const SizedBox(height: 8),
                  CustomButton(
                    text: 'logout_button'.tr(), // "Cerrar sesión"
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutEvent());
                    },
                  ),
                  if (!state.user.isPremium) ...[
                    const SizedBox(height: 16),
                    CustomButton(
                      text: 'upgrade_to_premium'.tr(), // "Actualizar a Premium"
                      onPressed: () {
                        // Navegar a la página de actualización a premium
                        // TODO: Implementar la navegación a la página de actualización
                      },
                    ),
                  ],
                ],
              );
            } else {
              return CustomButton(
                text: 'login_button'.tr(), // "Iniciar sesión"
                onPressed: () {
                  // Navegar a la página de inicio de sesión
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
