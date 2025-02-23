import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Color(0xFFFFFFFF), // Background color
    onInverseSurface: Color(0xFFE7E8A6), // Foreground color
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
  radioTheme: RadioThemeData(),
  unselectedWidgetColor: Colors.grey.shade900,
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    headerBackgroundColor: Color(0xFF8d4612),
    headerForegroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFF8d4612)),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color(0xFF8d4612)),
    ),
    // dayForegroundColor: WidgetStatePropertyAll(Colors.transparent),
    dayOverlayColor: WidgetStatePropertyAll(Color(0xFFff9800)),
    dayBackgroundColor: WidgetStatePropertyAll(Colors.transparent),
    dayStyle: TextStyle(color: Colors.pink),
    todayBackgroundColor: WidgetStatePropertyAll(Colors.transparent),
    dayShape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);
