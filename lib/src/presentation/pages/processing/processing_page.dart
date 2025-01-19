// lib/src/presentation/pages/processing/processing_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/app_routes.dart';
import '../../blocs/pdf_bloc.dart';
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
  const ProcessingPage({Key? key, required this.pdfId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('processing.title'.tr()),
      ),
      body: BlocConsumer<PdfBloc, PdfState>(
        listener: (context, state) {
          if (state is PdfProcessed) {
            AppNavigator.pushNamed(
              AppRoutes.playback,
              arguments: PlaybackScreenArguments(audioId: state.audioId),
            );
          } else if (state is PdfError) {
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
                    'processing.message'.tr(),
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

  Widget _buildProgressIndicator(PdfState state) {
    if (state is PdfProcessing) {
      return LinearProgressIndicator(value: state.progress);
    } else {
      return const CircularProgressIndicator();
    }
  }

  Widget _buildCancelButton(BuildContext context) {
    return CustomButton(
      text: 'processing.cancel_button'.tr(),
      onPressed: () => _showCancelConfirmationDialog(context),
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('processing.cancel_confirmation_title'.tr()),
          content: Text('processing.cancel_confirmation_message'.tr()),
          actions: <Widget>[
            TextButton(
              child: Text('common.no'.tr()),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('common.yes'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<PdfBloc>().add(CancelProcessingEvent(pdfId: pdfId));
                AppNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('common.error'.tr()),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('common.ok'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
                AppNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
