//lib/src/presentation/blocs/notification_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/handle_notifications_usecase.dart';

/// Eventos del NotificationBloc
abstract class NotificationEvent {}

class InitializeNotificationsEvent extends NotificationEvent {}

class ReceiveNotificationEvent extends NotificationEvent {
  final String title;
  final String body;

  ReceiveNotificationEvent({required this.title, required this.body});
}

/// Estados del NotificationBloc
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationReady extends NotificationState {}

class NotificationReceived extends NotificationState {
  final String title;
  final String body;

  NotificationReceived({required this.title, required this.body});
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}

/// BLoC para manejar notificaciones
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final HandleNotificationsUseCase handleNotificationsUseCase;

  NotificationBloc({required this.handleNotificationsUseCase}) : super(NotificationInitial()) {
    on<InitializeNotificationsEvent>(_onInitializeNotifications);
    on<ReceiveNotificationEvent>(_onReceiveNotification);
  }

  /// Maneja el evento de inicialización de notificaciones
  Future<void> _onInitializeNotifications(
    InitializeNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      await handleNotificationsUseCase.initialize();
      emit(NotificationReady());
    } catch (e) {
      emit(NotificationError('Error al inicializar las notificaciones: ${e.toString()}'));
    }
  }

  /// Maneja el evento de recepción de notificación
  void _onReceiveNotification(
    ReceiveNotificationEvent event,
    Emitter<NotificationState> emit,
  ) {
    emit(NotificationReceived(title: event.title, body: event.body));
  }
}
