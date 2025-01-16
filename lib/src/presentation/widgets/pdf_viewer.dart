//lib/src/presentation/widgets/pdf_viewer.dart
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

/// Widget para visualizar archivos PDF.
class PdfViewer extends StatelessWidget {
  /// La ruta del archivo PDF a visualizar.
  final String filePath;

  /// Constructor del PdfViewer.
  const PdfViewer({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visor de PDF'),
      ),
      body: _buildPdfView(),
    );
  }

  /// Construye la vista del PDF.
  Widget _buildPdfView() {
    return FutureBuilder<File>(
      future: _getFileFromPath(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar el PDF: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onError: (error) {
                print('Error al renderizar el PDF: $error');
              },
              onPageError: (page, error) {
                print('Error en la página $page: $error');
              },
            );
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  /// Obtiene el archivo File a partir de la ruta proporcionada.
  Future<File> _getFileFromPath() async {
    final file = File(filePath);
    if (await file.exists()) {
      return file;
    } else {
      throw Exception('El archivo no existe en la ruta especificada');
    }
  }
}
