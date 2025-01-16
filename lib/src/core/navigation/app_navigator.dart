//lib/src/core/navigation/app_navigator.dart
import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'page_transition.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> pushNamed<T>(AppRoute route, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(route.path, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T>(AppRoute route, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(route.path, arguments: arguments);
  }

  static void pop<T>([T? result]) {
    return navigatorKey.currentState!.pop(result);
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = AppRoute.values.firstWhere(
      (r) => r.path == settings.name,
      orElse: () => AppRoute.home,
    );

    switch (route) {
      case AppRoute.login:
      case AppRoute.home:
        return FadePageRoute(builder: (_) => route.getPage(), settings: settings);
      case AppRoute.utnValidation:
      case AppRoute.pdfUpload:
      case AppRoute.settings:
        return SlidePageRoute(builder: (_) => route.getPage(), settings: settings);
      case AppRoute.processing:
      case AppRoute.playback:
        return FadePageRoute(builder: (_) => route.getPage(settings.arguments), settings: settings);
    }
  }
}
