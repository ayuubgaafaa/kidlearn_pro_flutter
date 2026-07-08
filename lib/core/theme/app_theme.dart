import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryLight = Color(0xFF58CC02);
  static const Color primaryDark = Color(0xFF46A302);
  static const Color bgLight = Color(0xFFF7F7F7);
  static const Color textDark = Color(0xFF2B2B2B);
  static const Color textGrey = Color(0xFF777777);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryGreen,
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: primaryLight,
      surface: Colors.white,
      background: bgLight,
    ),
    scaffoldBackgroundColor: bgLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryGreen,
    colorScheme: const ColorScheme.dark(
      primary: primaryGreen,
      secondary: primaryLight,
      surface: Color(0xFF1E1E3A),
      background: Color(0xFF1A1A2E),
    ),
    scaffoldBackgroundColor: const Color(0xFF1A1A2E),
  );
}
