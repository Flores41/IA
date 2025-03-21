import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
     this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 840;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1300 &&
      MediaQuery.of(context).size.width >= 840;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1300;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (size.width >= 1300) {
      return desktop;
    } else if (size.width >= 840  )  {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
