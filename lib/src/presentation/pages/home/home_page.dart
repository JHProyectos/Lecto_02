// lib/src/presentation/pages/home/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../domain/entities/user.dart';
import '../../blocs/auth_bloc.dart';
import '../../blocs/pdf_bloc.dart';
import '../../widgets/custom_button.dart';

/// Página principal de la aplicación.
/// 
/// Esta página muestra un resumen de la actividad del usuario y proporciona
/// acceso a las principales funcionalidades de la aplicación.
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr()),
        actions: [
          // Botón para acceder a la página de configuración
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => AppNavigator.pushNamed(AppRoutes.settings),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return _buildAuthenticatedContent(context, state.user);
          } else {
            // Si el usuario no está autenticado, redirigir al login
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppNavigator.pushReplacementNamed(AppRoutes.login);
            });
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  /// Construye el contenido principal de la página para usuarios autenticados.
  Widget _buildAuthenticatedContent(BuildContext context, User user) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'home.welcome'.tr(args: [user.name]),
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 24),
            _buildUserInfo(user),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 24),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  /// Construye un widget que muestra la información del usuario.
  Widget _buildUserInfo(User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('home.user_type'.tr(args: [_getUserTypeString(user.userType)])),
            Text('home.subscription_status'.tr(args: [user.isPremium ? 'home.premium'.tr() : 'home.free'.tr()])),
            // Aquí se pueden agregar más detalles del usuario según sea necesario
          ],
        ),
      ),
    );
  }

  /// Construye los botones de acción principales.
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'home.actions.upload_pdf'.tr(),
          onPressed: () => AppNavigator.pushNamed(AppRoutes.upload),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'home.actions.view_processed_files'.tr(),
          onPressed: () {
            // Aquí se debería navegar a una página que muestre los archivos procesados
            // Por ahora, mostraremos un diálogo simple
            _showComingSoonDialog(context, 'home.actions.view_processed_files'.tr());
          },
        ),
      ],
    );
  }

  /// Construye un widget que muestra la actividad reciente del usuario.
  Widget _buildRecentActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('home.recent_activity'.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Aquí se debería mostrar una lista de actividades recientes
            // Por ahora, mostraremos un placeholder
            Text('home.no_recent_activity'.tr()),
          ],
        ),
      ),
    );
  }

  /// Muestra un diálogo simple para funcionalidades en desarrollo.
  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('common.coming_soon'.tr()),
          content: Text('home.feature_coming_soon'.tr(args: [feature])),
          actions: <Widget>[
            TextButton(
              child: Text('common.ok'.tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  /// Convierte el tipo de usuario en una cadena legible.
  String _getUserTypeString(UserType userType) {
    switch (userType) {
      case UserType.free:
        return 'home.user_types.free'.tr();
      case UserType.premium:
        return 'home.user_types.premium'.tr();
      case UserType.developer:
        return 'home.user_types.developer'.tr();
      case UserType.tester:
        return 'home.user_types.tester'.tr();
      case UserType.admin:
        return 'home.user_types.admin'.tr();
      case UserType.guest:
        return 'home.user_types.guest'.tr();
      default:
        return 'home.user_types.unknown'.tr();
    }
  }
}
