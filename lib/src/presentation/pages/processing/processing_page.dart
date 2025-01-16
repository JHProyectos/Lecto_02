// lib/src/presentation/pages/processing/processing_page.dart

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
import '../../blocs/pdf_bloc.dart';

// Widgets personalizados
import '../../widgets/custom_button.dart';

/// Página que muestra el progreso del procesamiento de un PDF.
///
/// Esta página se muestra mientras el PDF está siendo convertido a audio.
/// Proporciona información visual sobre el estado del proceso y permite
/// al usuario cancelar la operación si es necesario.
class ProcessingPage extends StatelessWidget {
  /// Identificador único del PDF que se está procesando.
  final String pdfId;

  /// Constructor de ProcessingPage.
  ///
  /// Requiere el [pdfId] del PDF que se está procesando.
  const ProcessingPage({Key? key, required this.pdfId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('processing_title'.tr()), // "Procesando PDF"
      ),
      body: BlocConsumer<PdfBloc, PdfState>(
        listener: (context, state) {
          if (state is PdfProcessed) {
            // Cuando el procesamiento está completo, navegar a la página de reproducción
            AppNavigator.pushNamed(
              AppRoutes.playback,
              arguments: PlaybackScreenArguments(audioId: state.audioId),
            );
          } else if (state is PdfError) {
            // Mostrar un diálogo de error si algo sale mal
            _showErrorDialog(context, state.message);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'processing_message'.tr(), // "Tu PDF se está convirtiendo en audio..."
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _buildProgressIndicator(state),
                  const SizedBox(height: 32),
                  _buildCancelButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Construye el indicador de progreso basado en el estado actual.
  Widget _buildProgressIndicator(PdfState state) {
    if (state is PdfProcessing) {
      // Si conocemos el progreso exacto, mostrar una barra de progreso
      return LinearProgressIndicator(value: state.progress);
    } else {
      // Si no conocemos el progreso exacto, mostrar un indicador indeterminado
      return const CircularProgressIndicator();
    }
  }

  /// Construye el botón para cancelar el procesamiento.
  Widget _buildCancelButton(BuildContext context) {
    return CustomButton(
      text: 'cancel_button'.tr(), // "Cancelar"
      onPressed: () {
        // Mostrar un diálogo de confirmación antes de cancelar
        _showCancelConfirmationDialog(context);
      },
    );
  }

  /// Muestra un diálogo de confirmación antes de cancelar el procesamiento.
  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('cancel_confirmation_title'.tr()), // "¿Cancelar procesamiento?"
          content: Text('cancel_confirmation_message'.tr()), // "¿Estás seguro de que deseas cancelar el procesamiento? El progreso se perderá."
          actions: <Widget>[
            TextButton(
              child: Text('no'.tr()), // "No"
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('yes'.tr()), // "Sí"
              onPressed: () {
                Navigator.of(context).pop();
                // Cancelar el procesamiento
                context.read<PdfBloc>().add(CancelProcessingEvent(pdfId: pdfId));
                // Volver a la página anterior
                AppNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Muestra un diálogo de error.
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('error_title'.tr()), // "Error"
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('ok'.tr()), // "Aceptar"
              onPressed: () {
                Navigator.of(context).pop();
                // Volver a la página anterior después de cerrar el diálogo de error
                AppNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
