import 'package:flutter/material.dart';

/// Función reutilizable para navegar con animaciones personalizadas
Route createRoute(Widget page,
    {RouteTransitionType transitionType = RouteTransitionType.fade}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case RouteTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case RouteTransitionType.slide:
          return SlideTransition(
            position: animation
                .drive(Tween(begin: Offset(1.0, 0.0), end: Offset.zero).chain(
              CurveTween(
                curve: Curves.easeInOut,
              ),
            )),
            child: child,
          );
        case RouteTransitionType.scale:
          return ScaleTransition(scale: animation, child: child);
        case RouteTransitionType.rotation:
          return RotationTransition(turns: animation, child: child);
      }
    },
  );
}

/// Enum para seleccionar el tipo de animación
enum RouteTransitionType { fade, slide, scale, rotation }
