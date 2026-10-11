import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',

    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF176B87),
    ),

    scaffoldBackgroundColor: const Color(0xFFF7FAFC),

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
  );
}