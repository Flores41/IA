import 'package:coreia/main.dart';
import 'package:coreia/src/core/app/routes/route_utils.dart';
import 'package:coreia/src/core/screens/auth/login_screen.dart';
import 'package:coreia/src/core/screens/auth/register_screen.dart';
import 'package:coreia/src/core/screens/home/home_screen.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return createRoute(
          const AuthGate(),
          transitionType: RouteTransitionType.slide,
        );
      case '/home':
        return createRoute(
          const HomeScreen(),
          transitionType: RouteTransitionType.slide,
        );
      case '/login':
        return createRoute(
          const LoginScreen(),
          transitionType: RouteTransitionType.slide,
        );
      case '/register':
        return createRoute(
          const RegisterScreen(),
          transitionType: RouteTransitionType.slide,
        );
      // case '/settings':
      //   return createRoute(
      //     SettingsScreen(),
      //     transitionType: RouteTransitionType.slide,
      //   );

      default:
        return null;
    }
  }
}
