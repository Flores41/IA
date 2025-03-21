import 'package:flutter/material.dart';



extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}

extension ColorExtension on Color {
//   Color get primary => const Color(0XFFF3F2F7);
//   Color get title => const Color(0xFF012131);
//   Color get subTitle => const Color(0xff5d577e);
//   Color get sombra => const Color(0xFF007EE5);
//   Color get sombra2 => const Color.fromARGB(255, 174, 205, 231);
//   Color get sombra3 => const Color(0xffEDEFFF);
//   Color get form => const Color(0xfff3f1f1);
//   Color get black => const Color(0xff000000);
//   Color get white => const Color(0xffffffff);
//   Color get cRed => const Color(0xffe53935);
//   Color get cGreen => const Color(0xff43a047);


  Color get primary => const Color(0xff4880ff);
  Color get secondary => const Color(0xfff3f2f7);
  Color get cBackground => const Color(0XFFF2F0FF);
  Color get white => const Color(0XFFFFFFFF);
  Color get black => const Color(0XFF000000);
  Color get darkGrey => const Color(0XFF7F8C8D);
  Color get success => const Color(0XFF679F00);
  Color get cOrange => const Color(0XFFE67E22);
  Color get error => const Color(0XFFB00020);
  Color get card => const Color(0xfff3f4f6);



}