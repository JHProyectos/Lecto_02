// lib/src/presentation/widgets/audio_player_widget.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';

/// Widget personalizado para reproducir audio.
/// Este widget permite reproducir, pausar, cambiar la velocidad de reproducción (si el usuario tiene acceso premium),
/// y mostrar la posición actual y la duración total del archivo de audio.
class AudioPlayerWidget extends StatefulWidget {
  /// URL del archivo de audio que se desea reproducir.
  final String audioUrl;

  /// Posición inicial opcional desde la cual empezar a reproducir el audio.
  final Duration? initialPosition;

  /// Indica si el usuario tiene acceso a funciones premium, como cambiar la velocidad de reproducción.
  final bool isPremium;

  /// Constructor del widget.
  const AudioPlayerWidget({
    Key? key,
    required this.audioUrl,
    this.initialPosition,
    required this.isPremium,
  }) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer; // Instancia del reproductor de audio.
  bool _isPlaying = false; // Indica si el audio está en reproducción.
  Duration _duration = Duration.zero; // Duración total del audio.
  Duration _position = Duration.zero; // Posición actual del audio.
  double _playbackRate = 1.0; // Velocidad de reproducción actual.

  @override
  void initState() {
    super.initState();
    _initAudioPlayer(); // Inicializa el reproductor de audio al cargar el widget.
  }

  /// Inicializa el reproductor de audio y configura los escuchadores de eventos.
  void _initAudioPlayer() async {
    _audioPlayer = AudioPlayer();

    // Configura la fuente del audio.
    await _audioPlayer.setSourceUrl(widget.audioUrl);

    // Si se proporciona una posición inicial, ajusta el audio a esa posición.
    if (widget.initialPosition != null) {
      await _audioPlayer.seek(widget.initialPosition!);
    }

    // Escucha los cambios en la duración total del audio.
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    // Escucha los cambios en la posición actual del audio.
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    // Escucha cuando el audio termina de reproducirse.
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  /// Reproduce el audio desde la posición actual.
  Future<void> play() async {
    await _audioPlayer.resume();
    setState(() {
      _isPlaying = true;
    });
  }

  /// Pausa la reproducción del audio.
  Future<void> pause() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  /// Cambia la posición actual del audio.
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// Cambia la velocidad de reproducción del audio.
  /// Si el usuario no tiene acceso premium, muestra un diálogo informativo.
  Future<void> setPlaybackRate(double rate) async {
    if (widget.isPremium) {
      await _audioPlayer.setPlaybackRate(rate);
      setState(() {
        _playbackRate = rate;
      });
    } else {
      _showPremiumDialog();
    }
  }

  /// Muestra un diálogo indicando que cambiar la velocidad es una función premium.
  void _showPremiumDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('audio_player.premium_feature'.tr()), // Título traducido.
          content: Text('audio_player.premium_feature_description'.tr()), // Descripción traducida.
          actions: <Widget>[
            TextButton(
              child: Text('common.cancel'.tr()), // Botón traducido para cancelar.
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('audio_player.upgrade'.tr()), // Botón traducido para actualizar.
              onPressed: () {
                // Lógica para actualizar a premium.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Construye el widget visual del reproductor de audio.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra deslizante para mostrar y controlar la posición del audio.
        Slider(
          min: 0,
          max: _duration.inSeconds.toDouble(),
          value: _position.inSeconds.toDouble(),
          onChanged: (value) {
            final position = Duration(seconds: value.toInt());
            seek(position);
          },
        ),
        // Muestra la posición actual y el tiempo restante del audio.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_position)), // Tiempo reproducido.
              Text(_formatDuration(_duration - _position)), // Tiempo restante.
            ],
          ),
        ),
        // Controles de reproducción y velocidad.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _isPlaying ? pause : play,
            ),
            // Selector de velocidad de reproducción.
            PopupMenuButton<double>(
              child: Chip(
                label: Text('${_playbackRate}x'), // Velocidad actual.
              ),
              onSelected: setPlaybackRate,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<double>>[
                PopupMenuItem<double>(
                  value: 0.75,
                  child: Text('0.75x'),
                ),
                PopupMenuItem<double>(
                  value: 1.0,
                  child: Text('1.0x'),
                ),
                PopupMenuItem<double>(
                  value: 1.25,
                  child: Text('1.25x'),
                ),
                PopupMenuItem<double>(
                  value: 1.5,
                  child: Text('1.5x'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Formatea la duración en un formato legible (HH:mm:ss).
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "\${twoDigits(duration.inHours)}:\$twoDigitMinutes:\$twoDigitSeconds";
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Libera los recursos del reproductor de audio.
    super.dispose();
  }
}
