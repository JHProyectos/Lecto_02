// lib/src/presentation/pages/auth/login_page.dart

// Widgets y funcionalidades básicas de Flutter
import 'package:flutter/material.dart';

// Gestión de estado
import 'package:flutter_bloc/flutter_bloc.dart';

// Localización
import 'package:easy_localization/easy_localization.dart';

// Navegación y rutas
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/app_routes.dart';

// Blocs
import '../../blocs/auth_bloc.dart';

// Widgets personalizados
import '../../widgets/app_logo.dart';
import '../../widgets/custom_button.dart';

/// Página de inicio de sesión de la aplicación.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Maneja el proceso de inicio de sesión.
  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            LoginEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            // Muestra un snackbar con el mensaje de error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message.tr())),
            );
          } else if (state is AuthAuthenticated) {
            // Navega a la página principal si la autenticación es exitosa
            AppNavigator.pushReplacementNamed(AppRoutes.home);
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogo(size: 120),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'auth.email'.tr(), // "Correo electrónico"
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'auth.email_required'.tr(); // "Por favor, ingrese su correo electrónico"
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'auth.password'.tr(), // "Contraseña"
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'auth.password_required'.tr(); // "Por favor, ingrese su contraseña"
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'auth.login'.tr(), // "Iniciar sesión"
                      onPressed: _handleLogin,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Navega a la página de validación de UTN
                        AppNavigator.pushNamed(AppRoutes.utnValidation);
                      },
                      child: Text('auth.register_prompt'.tr()), // "¿No tienes cuenta? Regístrate aquí"
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
