import 'package:flutter/material.dart';
import 'package:todo_list/screens/screens.dart';

class AppRouter {
  static const String splashScreenRoute = '/';
  static const String home = '/homeScreen';

  const AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
