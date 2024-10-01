import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightThemedata =
      ThemeData.light(useMaterial3: true).copyWith(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    cardTheme: const CardTheme(
      color: Colors.white,
      elevation: 1,
      surfaceTintColor: Colors.transparent,
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        color: Colors.white,
        centerTitle: true),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
    ),
  );

  static ThemeData darkThemedata = ThemeData.dark(useMaterial3: true).copyWith(
    primaryColor: Colors.red,
    scaffoldBackgroundColor: Colors.red,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      color: Colors.red,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.red,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
