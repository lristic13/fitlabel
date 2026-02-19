import 'package:flutter/material.dart';

import 'package:fitlabel/config/models/tenant_config.dart';

class AppTheme {
  static ThemeData fromConfig(TenantConfig? config) {
    final primaryColor = _parseColor(config?.primaryColor) ?? Colors.deepPurple;
    final secondaryColor =
        _parseColor(config?.secondaryColor) ?? Colors.deepPurpleAccent;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      secondary: secondaryColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static Color? _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return null;
    final cleaned = hex.replaceFirst('#', '');
    if (cleaned.length != 6) return null;
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) return null;
    return Color(0xFF000000 | value);
  }
}
