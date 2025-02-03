import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Color(0xFFFFFFFF), // Background color
    onSurface: Color(0xFFE7E8A6), // Foreground color
    primary: Colors.grey.shade900,
    onPrimary: Color(0xFF8d4612), // Primary Button Color
    secondary: Color(0xFFff9800), // Secondary Button Color
    tertiary: Color(0xFF939598), // Tertiary Color
    inversePrimary: Colors.white,
  ),
  dialogTheme: DialogTheme(
    titleTextStyle: TextStyle(color: Colors.grey.shade500),
    contentTextStyle: TextStyle(color: Colors.grey.shade500),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all(Colors.white),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF8d4612), // Primary Button Color
      foregroundColor: Colors.white,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFFff9800), // Secondary Button Color
      side: BorderSide(color: Color(0xFFff9800)),
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Color(0xFFff9800), // CircularProgressIndicator color
  ),
);
