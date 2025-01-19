// lib/src/presentation/pages/upload/upload_page.dart

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/app_routes.dart';
import '../../blocs/pdf_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../../services/file_service.dart';

/// Página para cargar archivos PDF.
///
/// Esta página permite al usuario seleccionar y cargar un archivo PDF
/// para su posterior procesamiento y conversión a audio.
class UploadPage extends StatefulWidget {
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
        title: Text('upload.title'.tr()),
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

  Widget _buildInstructions() {
    return Text(
      'upload.instructions'.tr(),
      style: Theme.of(context).textTheme.subtitle1,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFileSelection() {
    return Column(
      children: [
        CustomButton(
          text: 'upload.select_file'.tr(),
          onPressed: _selectFile,
        ),
        const SizedBox(height: 8),
        if (_selectedFilePath != null)
          Text(
            'upload.selected_file'.tr(args: [_selectedFilePath!.split('/').last]),
            style: Theme.of(context).textTheme.bodyText2,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }

  Widget _buildUploadButton() {
    return BlocConsumer<PdfBloc, PdfState>(
      listener: (context, state) {
        if (state is PdfUploaded) {
          AppNavigator.pushNamed(
            AppRoutes.processing,
            arguments: state.pdf.id,
          );
        } else if (state is PdfError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return CustomButton(
          text: 'upload.upload_button'.tr(),
          onPressed: _selectedFilePath != null
              ? () => _uploadFile(context)
              : null,
          isLoading: state is PdfUploading,
        );
      },
    );
  }

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
        SnackBar(content: Text('upload.file_selection_error'.tr())),
      );
    }
  }

  void _uploadFile(BuildContext context) {
    if (_selectedFilePath != null) {
      context.read<PdfBloc>().add(UploadPdfEvent(_selectedFilePath!));
    }
  }
}
