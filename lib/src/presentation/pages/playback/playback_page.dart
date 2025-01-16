// lib/src/presentation/pages/playback/playback_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/audio.dart';
import '../../../domain/entities/user.dart';
import '../../blocs/audio_bloc.dart';
import '../../widgets/audio_player.dart';

/// Página para la reproducción de audio.
/// 
/// Esta página permite al usuario reproducir el audio generado a partir de un PDF.
/// Incluye controles de reproducción y opciones adicionales para usuarios premium.
class PlaybackPage extends StatelessWidget {
  /// El audio a reproducir.
  final Audio audio;

  /// El usuario actual.
  final User user;

  /// Constructor de PlaybackPage.
  const PlaybackPage({
    Key? key,
    required this.audio,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reproducción de Audio'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reproduciendo: ${audio.name}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 24),
              BlocProvider(
                create: (context) => AudioBloc(
                  playAudioUseCase: context.read(),
                )..add(PlayAudioEvent(audio)),
                child: AudioPlayerWidget(audio: audio, user: user),
              ),
              const SizedBox(height: 24),
              _buildAdditionalOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Construye opciones adicionales para la reproducción de audio.
  Widget _buildAdditionalOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opciones adicionales',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 8),
        // Opción para descargar el audio (solo para usuarios premium)
        ListTile(
          leading: const Icon(Icons.download),
          title: const Text('Descargar audio'),
          onTap: user.isPremium
              ? () => _handleDownload(context)
              : () => _showPremiumFeatureDialog(context),
          enabled: user.isPremium,
        ),
        // Aquí se pueden agregar más opciones según sea necesario
      ],
    );
  }

  /// Maneja la acción de descarga del audio.
  void _handleDownload(BuildContext context) {
    // Aquí se implementaría la lógica de descarga del audio
    // Por ahora, mostraremos un diálogo simple
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Descarga iniciada'),
          content: const Text('Tu audio se está descargando...'),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  /// Muestra un diálogo para funciones premium cuando un usuario no premium intenta acceder.
  void _showPremiumFeatureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Función Premium'),
          content: const Text('Esta función está disponible solo para usuarios premium. ¿Deseas actualizar tu cuenta?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No, gracias'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Actualizar'),
              onPressed: () {
                Navigator.of(context).pop();
                // Aquí se debería navegar a la página de actualización de cuenta
                // Por ahora, solo cerraremos el diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
