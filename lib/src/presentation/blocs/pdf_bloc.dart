//lib/src/presentation/blocs/pdf_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/upload_pdf_usecase.dart';
import '../../domain/usecases/validate_pdf_usecase.dart';
import '../../domain/entities/pdf.dart';

/// Eventos del PdfBloc
abstract class PdfEvent {}

class UploadPdfEvent extends PdfEvent {
  final String filePath;

  UploadPdfEvent(this.filePath);
}

class ValidatePdfEvent extends PdfEvent {
  final Pdf pdf;

  ValidatePdfEvent(this.pdf);
}

/// Estados del PdfBloc
abstract class PdfState {}

class PdfInitial extends PdfState {}

class PdfLoading extends PdfState {}

class PdfUploaded extends PdfState {
  final Pdf pdf;

  PdfUploaded(this.pdf);
}

class PdfValidated extends PdfState {
  final bool isValid;

  PdfValidated(this.isValid);
}

class PdfError extends PdfState {
  final String message;

  PdfError(this.message);
}

/// BLoC para manejar operaciones con PDFs
class PdfBloc extends Bloc<PdfEvent, PdfState> {
  final UploadPdfUseCase uploadPdfUseCase;
  final ValidatePdfUseCase validatePdfUseCase;

  PdfBloc({
    required this.uploadPdfUseCase,
    required this.validatePdfUseCase,
  }) : super(PdfInitial()) {
    on<UploadPdfEvent>(_onUploadPdf);
    on<ValidatePdfEvent>(_onValidatePdf);
  }

  /// Maneja el evento de subida de PDF
  Future<void> _onUploadPdf(UploadPdfEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());
    try {
      final pdf = await uploadPdfUseCase.execute(Pdf(
        id: '',
        name: event.filePath.split('/').last,
        path: event.filePath,
        userId: '',
        pageCount: 0,
      ));
      emit(PdfUploaded(pdf));
    } catch (e) {
      emit(PdfError('Error al subir el PDF: ${e.toString()}'));
    }
  }

  /// Maneja el evento de validación de PDF
  Future<void> _onValidatePdf(ValidatePdfEvent event, Emitter<PdfState> emit) async {
    emit(PdfLoading());
    try {
      final isValid = await validatePdfUseCase.execute(event.pdf);
      emit(PdfValidated(isValid));
    } catch (e) {
      emit(PdfError('Error al validar el PDF: ${e.toString()}'));
    }
  }
}
