import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[50],
  ),
  colorScheme: ColorScheme.light(
    background: Colors.grey[50]!,
    primary: Color(0xff091326),
    secondary: Colors.grey[300]!,
    tertiary: Colors.white,
  )
);