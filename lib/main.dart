import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'src/core/providers/theme_provider.dart';
import 'src/core/navigation/routes.dart';
import 'src/core/navigation/app_navigator.dart';
import 'src/core/pages/settings_page.dart';
import 'src/core/navigation/route_arguments.dart';
import 'src/features/processing/processing_screen.dart';
import 'src/features/playback/playback_screen.dart';
import 'src/services/update_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Verificar actualizaciones al inicio de la aplicación
  final updateChecker = UpdateChecker();
  final isUpdateAvailable = await updateChecker.isUpdateAvailable();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: StaticResources.translationPath,
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: MyApp(isUpdateAvailable: isUpdateAvailable),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isUpdateAvailable;

  const MyApp({Key? key, required this.isUpdateAvailable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
          themeMode: themeProvider.themeMode,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          home: isUpdateAvailable ? UpdatePromptScreen() : const SettingsPage(),
          navigatorKey: AppNavigator.navigatorKey,
          navigatorObservers: [AppNavigatorObserver()],
          onGenerateRoute: (settings) {
            final args = settings.arguments;
            
            switch (settings.name) {
              case AppRoute.processing.path:
                if (args is ProcessingArguments) {
                  return MaterialPageRoute(
                    builder: (_) => ProcessingScreen(
                      fileName: args.fileName,
                      fileSize: args.fileSize,
                    ),
                  );
                }
                return _errorRoute();
              
              case AppRoute.playback.path:
                if (args is PlaybackArguments) {
                  return MaterialPageRoute(
                    builder: (_) => PlaybackScreen(
                      audioFile: args.audioFile,
                      duration: args.duration,
                    ),
                  );
                }
                return _errorRoute();
              
              default:
                return _errorRoute();
            }
          },
        );
      },
    );
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('Error: Ruta no encontrada'),
        ),
      ),
    );
  }
}

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Nueva ruta: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Ruta eliminada: ${route.settings.name}');
  }
}

class UpdatePromptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hay una nueva actualización disponible.'),
            ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.tuapp"));
              },
              child: Text('Actualizar ahora'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => SettingsPage()),
                );
              },
              child: Text('Más tarde'),
            ),
          ],
        ),
      ),
    );
  }
}
