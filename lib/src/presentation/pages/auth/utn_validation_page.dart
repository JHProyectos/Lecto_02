// lib/src/presentation/pages/auth/utn_validation_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/app_routes.dart';
import '../../../domain/usecases/validate_utn_id_usecase.dart';
import '../../blocs/auth_bloc.dart';
import '../../widgets/custom_button.dart';

/// Página para validar el ID de UTN durante el registro.
class UTNValidationPage extends StatefulWidget {
  const UTNValidationPage({Key? key}) : super(key: key);

  @override
  _UTNValidationPageState createState() => _UTNValidationPageState();
}

class _UTNValidationPageState extends State<UTNValidationPage> {
  final _formKey = GlobalKey<FormState>();
  final _utnIdController = TextEditingController();

  @override
  void dispose() {
    _utnIdController.dispose();
    super.dispose();
  }

  /// Maneja el proceso de validación del ID de UTN.
  void _handleValidation() {
    if (_formKey.currentState!.validate()) {
      // Aquí se debería llamar al caso de uso para validar el ID de UTN
      // Por ahora, simularemos una validación exitosa
      _showSuccessDialog();
    }
  }

  /// Muestra un diálogo de éxito después de la validación.
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('common.success'.tr()),
          content: Text('auth.utn_validation_success'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('common.ok'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
                // Aquí se debería navegar a la página de registro completo
                // Por ahora, volveremos a la página de inicio de sesión
                AppNavigator.pushReplacementNamed(AppRoutes.login);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.utn_validation_title'.tr()),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'auth.enter_utn_id'.tr(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _utnIdController,
                    decoration: InputDecoration(
                      labelText: 'auth.utn_id'.tr(),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'auth.utn_id_required'.tr();
                      }
                      // Aquí se pueden agregar más validaciones específicas para el formato del ID de UTN
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'auth.validate_id'.tr(),
                    onPressed: _handleValidation,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
