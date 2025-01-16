// lib/src/presentation/pages/home/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: const Text('Inicio'),
        actions: [
          // Botón para acceder a la página de configuración
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
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
              Navigator.of(context).pushReplacementNamed('/login');
            });
            return const Center(child: CircularProgressIndicator());
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
              'Bienvenido, ${user.name}',
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
            Text('Tipo de usuario: ${_getUserTypeString(user.userType)}'),
            Text('Estado de suscripción: ${user.isPremium ? 'Premium' : 'Gratuito'}'),
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
          text: 'Subir nuevo PDF',
          onPressed: () => Navigator.of(context).pushNamed('/upload'),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Ver archivos procesados',
          onPressed: () {
            // Aquí se debería navegar a una página que muestre los archivos procesados
            // Por ahora, mostraremos un diálogo simple
            _showComingSoonDialog(context, 'Ver archivos procesados');
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
            Text('Actividad reciente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // Aquí se debería mostrar una lista de actividades recientes
            // Por ahora, mostraremos un placeholder
            Text('No hay actividad reciente para mostrar.'),
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
          title: const Text('Próximamente'),
          content: Text('La función "$feature" estará disponible pronto.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
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
        return 'Gratuito';
      case UserType.premium:
        return 'Premium';
      case UserType.developer:
        return 'Desarrollador';
      case UserType.tester:
        return 'Tester';
      case UserType.admin:
        return 'Administrador';
      case UserType.guest:
        return 'Invitado';
      default:
        return 'Desconocido';
    }
  }
}
