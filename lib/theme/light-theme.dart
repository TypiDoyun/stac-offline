import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[50],
  ),
  colorScheme: ColorScheme.light(
    background: Color(0xfffefefe),
    primary: Colors.black,
    secondary: Colors.white,
    tertiary: Color(0xff535353),
    outline: Colors.black,
  )
);