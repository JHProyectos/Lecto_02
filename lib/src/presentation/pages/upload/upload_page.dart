// lib/src/presentation/pages/upload/upload_page.dart

// Widgets y funcionalidades básicas de Flutter
import 'package:flutter/material.dart';

// Localización
import 'package:easy_localization/easy_localization.dart';

// Gestión de estado
import 'package:flutter_bloc/flutter_bloc.dart';

// Navegación y rutas
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/app_routes.dart';

// Blocs
import '../../blocs/pdf_bloc.dart';

// Widgets personalizados
import '../../widgets/custom_button.dart';

// Servicios
import '../../../services/file_service.dart';

/// Página para cargar archivos PDF.
///
/// Esta página permite al usuario seleccionar y cargar un archivo PDF
/// para su posterior procesamiento y conversión a audio.
class UploadPage extends StatefulWidget {
  /// Constructor de UploadPage.
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? _selectedFilePath;
  final FileService _fileService = FileService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload_title'.tr()), // "Subir PDF"
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInstructions(),
              const SizedBox(height: 24),
              _buildFileSelection(),
              const SizedBox(height: 24),
              _buildUploadButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Construye el widget de instrucciones para el usuario.
  Widget _buildInstructions() {
    return Text(
      'upload_instructions'.tr(), // "Selecciona un archivo PDF para convertirlo a audio."
      style: Theme.of(context).textTheme.subtitle1,
      textAlign: TextAlign.center,
    );
  }

  /// Construye el widget para la selección de archivos.
  Widget _buildFileSelection() {
    return Column(
      children: [
        CustomButton(
          text: 'select_file'.tr(), // "Seleccionar archivo"
          onPressed: _selectFile,
        ),
        const SizedBox(height: 8),
        if (_selectedFilePath != null)
          Text(
            'selected_file'.tr(args: [_selectedFilePath!.split('/').last]), // "Archivo seleccionado: {filename}"
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  /// Construye el botón de carga de archivos.
  Widget _buildUploadButton() {
    return BlocConsumer<PdfBloc, PdfState>(
      listener: (context, state) {
        if (state is PdfUploaded) {
          // Navegar a la página de procesamiento cuando el PDF se haya cargado exitosamente
          AppNavigator.pushNamed(
            AppRoutes.processing,
            arguments: state.pdf.id,
          );
        } else if (state is PdfError) {
          // Mostrar un snackbar con el mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          text: 'upload_button'.tr(), // "Subir y procesar"
          onPressed: _selectedFilePath != null
              ? () => _uploadFile(context)
              : null,
          isLoading: state is PdfUploading,
        );
      },
    );
  }

  /// Maneja la selección de archivos.
  Future<void> _selectFile() async {
    try {
      final filePath = await _fileService.pickPdfFile();
      if (filePath != null) {
        setState(() {
          _selectedFilePath = filePath;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('file_selection_error'.tr())), // "Error al seleccionar el archivo"
      );
    }
  }

  /// Maneja la carga del archivo seleccionado.
  void _uploadFile(BuildContext context) {
    if (_selectedFilePath != null) {
      context.read<PdfBloc>().add(UploadPdfEvent(_selectedFilePath!));
    }
  }
}
