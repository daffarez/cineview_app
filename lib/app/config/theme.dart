import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Warna utama (Dark Cinema Theme)
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color primaryRed = Color(
    0xFFE50914,
  );
  static const Color accentGold = Color(0xFFFFD700);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color seatAvailable = Color(0xFF3F3F46);
  static const Color seatSelected = Color(0xFFE50914);
  static const Color seatBooked = Color(0xFF52525B);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: primaryRed,
      colorScheme: const ColorScheme.dark(
        primary: primaryRed,
        surface: surfaceDark,
        background: backgroundDark,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    );
  }
}
