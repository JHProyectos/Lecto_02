//lib/src/presentation/blocs/audio_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/play_audio_usecase.dart';
import '../../domain/entities/audio.dart';

/// Eventos del AudioBloc
abstract class AudioEvent {}

class PlayAudioEvent extends AudioEvent {
  final Audio audio;

  PlayAudioEvent(this.audio);
}

class PauseAudioEvent extends AudioEvent {}

class StopAudioEvent extends AudioEvent {}

class SeekAudioEvent extends AudioEvent {
  final Duration position;

  SeekAudioEvent(this.position);
}

/// Estados del AudioBloc
abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioLoading extends AudioState {}

class AudioPlaying extends AudioState {
  final Audio audio;
  final Duration position;

  AudioPlaying(this.audio, this.position);
}

class AudioPaused extends AudioState {
  final Audio audio;
  final Duration position;

  AudioPaused(this.audio, this.position);
}

class AudioStopped extends AudioState {}

class AudioError extends AudioState {
  final String message;

  AudioError(this.message);
}

/// BLoC para manejar la reproducción de audio
class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final PlayAudioUseCase playAudioUseCase;

  AudioBloc({required this.playAudioUseCase}) : super(AudioInitial()) {
    on<PlayAudioEvent>(_onPlayAudio);
    on<PauseAudioEvent>(_onPauseAudio);
    on<StopAudioEvent>(_onStopAudio);
    on<SeekAudioEvent>(_onSeekAudio);
  }

  /// Maneja el evento de reproducción de audio
  Future<void> _onPlayAudio(PlayAudioEvent event, Emitter<AudioState> emit) async {
    emit(AudioLoading());
    try {
      await for (final position in playAudioUseCase.execute(event.audio.id)) {
        emit(AudioPlaying(event.audio, position));
      }
    } catch (e) {
      emit(AudioError('Error al reproducir el audio: ${e.toString()}'));
    }
  }

  /// Maneja el evento de pausa de audio
  Future<void> _onPauseAudio(PauseAudioEvent event, Emitter<AudioState> emit) async {
    if (state is AudioPlaying) {
      final currentState = state as AudioPlaying;
      emit(AudioPaused(currentState.audio, currentState.position));
    }
  }

  /// Maneja el evento de detención de audio
  Future<void> _onStopAudio(StopAudioEvent event, Emitter<AudioState> emit) async {
    emit(AudioStopped());
  }

  /// Maneja el evento de búsqueda en el audio
  Future<void> _onSeekAudio(SeekAudioEvent event, Emitter<AudioState> emit) async {
    if (state is AudioPlaying) {
      final currentState = state as AudioPlaying;
      emit(AudioPlaying(currentState.audio, event.position));
    } else if (state is AudioPaused) {
      final currentState = state as AudioPaused;
      emit(AudioPaused(currentState.audio, event.position));
    }
  }
}
