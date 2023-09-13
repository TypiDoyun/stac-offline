import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "LINESeedKR",
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xfffefefe),
    foregroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.light(
    background: Color(0xfffefefe),
    primary: Colors.black,
    primaryContainer: Colors.white,
    secondary: Colors.white,
    secondaryContainer: Colors.black,
    onSecondary: Color(0xff898989),
    onSecondaryContainer: Color(0xffEFEFEF),
    tertiary: Colors.white,
    tertiaryContainer: Color(0xff232323),
    onTertiaryContainer: Colors.black,
    outline: Colors.black,
  )
);