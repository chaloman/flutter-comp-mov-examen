import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.orange;
  static final ThemeData appTheme = ThemeData(
      primaryColor: primary,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: primary,
        elevation: 15,
      ),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: primary)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: primary));
}