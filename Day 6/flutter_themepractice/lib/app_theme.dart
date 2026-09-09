import 'package:flutter/material.dart';


class AppColors {

  static const seed = Color(0xFF4F46E5);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF121212);
  static const textPrimaryLight = Color(0xFF1A1A1A);
  static const textPrimaryDark = Color(0xFFF5F5F5);
}
class AppTheme {
  static ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seed,
    brightness: Brightness.light,
  );

  static ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seed,
    brightness: Brightness.dark,
  );

  static TextTheme _textTheme(ColorScheme scheme) {
    return TextTheme(
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: scheme.onSurface),
      titleMedium: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: scheme.onSurface),
      bodyLarge: TextStyle(fontSize: 16, color: scheme.onSurface),
      bodyMedium: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: scheme.onPrimary),
    );
  }
  static ThemeData _buildTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: _textTheme(scheme),
      scaffoldBackgroundColor: scheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),

      cardTheme: CardThemeData(
        color: scheme.surfaceContainerHighest,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData light = _buildTheme(lightScheme);
  static ThemeData dark = _buildTheme(darkScheme);
}