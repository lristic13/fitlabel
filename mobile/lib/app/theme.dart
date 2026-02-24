import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fitlabel/config/models/tenant_config.dart';

class AppTheme {
  AppTheme._();

  // ── Light Theme ──────────────────────────────────────────────────────
  static ThemeData lightTheme(TenantConfig? config) {
    final primary = _parseColor(config?.primaryColor) ?? const Color(0xFF6C3AED);
    final secondary =
        _parseColor(config?.secondaryColor) ?? const Color(0xFF8B5CF6);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      brightness: Brightness.light,
      surface: const Color(0xFFFAFAFA),
      onSurface: const Color(0xFF1A1A1A),
    );

    final textTheme = _buildTextTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      appBarTheme: _appBarTheme(colorScheme, textTheme),
      cardTheme: _cardTheme(colorScheme, Brightness.light),
      filledButtonTheme: _filledButtonTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      navigationBarTheme: _navigationBarTheme(colorScheme),
      chipTheme: _chipTheme(colorScheme),
      progressIndicatorTheme: _progressIndicatorTheme(colorScheme),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        thickness: 1,
      ),
    );
  }

  // ── Dark Theme ───────────────────────────────────────────────────────
  static ThemeData darkTheme(TenantConfig? config) {
    final primary = _parseColor(config?.primaryColor) ?? const Color(0xFF6C3AED);
    final secondary =
        _parseColor(config?.secondaryColor) ?? const Color(0xFF8B5CF6);
    final adjustedPrimary = _adjustForDarkMode(primary);

    final colorScheme = ColorScheme.fromSeed(
      seedColor: adjustedPrimary,
      primary: adjustedPrimary,
      secondary: secondary,
      brightness: Brightness.dark,
      surface: const Color(0xFF121212),
      onSurface: const Color(0xFFF5F5F5),
    );

    final textTheme = _buildTextTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: _appBarTheme(colorScheme, textTheme),
      cardTheme: _cardTheme(colorScheme, Brightness.dark),
      filledButtonTheme: _filledButtonTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      navigationBarTheme: _navigationBarTheme(colorScheme),
      chipTheme: _chipTheme(colorScheme),
      progressIndicatorTheme: _progressIndicatorTheme(colorScheme),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant.withValues(alpha: 0.3),
        thickness: 1,
      ),
    );
  }

  // ── Typography ───────────────────────────────────────────────────────
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final base = GoogleFonts.interTextTheme();

    return base.copyWith(
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: colorScheme.onSurface,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        color: colorScheme.onSurface,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        color: colorScheme.onSurface,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        color: colorScheme.onSurface,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleSmall: base.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  // ── Component Themes ─────────────────────────────────────────────────

  static AppBarTheme _appBarTheme(ColorScheme cs, TextTheme tt) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      backgroundColor: cs.surface,
      foregroundColor: cs.onSurface,
      titleTextStyle: tt.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: cs.onSurface,
      ),
    );
  }

  static CardThemeData _cardTheme(ColorScheme cs, Brightness brightness) {
    return CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: brightness == Brightness.light
              ? cs.outlineVariant.withValues(alpha: 0.3)
              : cs.outlineVariant.withValues(alpha: 0.15),
        ),
      ),
      color: brightness == Brightness.light
          ? Colors.white
          : const Color(0xFF1E1E1E),
      surfaceTintColor: Colors.transparent,
    );
  }

  static FilledButtonThemeData _filledButtonTheme(ColorScheme cs) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: cs.primary,
        foregroundColor: _contrastingTextColor(cs.primary),
        textStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme cs) {
    return InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cs.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  static NavigationBarThemeData _navigationBarTheme(ColorScheme cs) {
    return NavigationBarThemeData(
      height: 64,
      elevation: 0,
      backgroundColor: cs.surface,
      indicatorColor: cs.primary.withValues(alpha: 0.15),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: cs.primary, size: 24);
        }
        return IconThemeData(color: cs.onSurfaceVariant, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: cs.primary,
          );
        }
        return GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: cs.onSurfaceVariant,
        );
      }),
    );
  }

  static ChipThemeData _chipTheme(ColorScheme cs) {
    return ChipThemeData(
      shape: const StadiumBorder(),
      showCheckmark: false,
      selectedColor: cs.primary,
      backgroundColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
      labelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }

  static ProgressIndicatorThemeData _progressIndicatorTheme(ColorScheme cs) {
    return ProgressIndicatorThemeData(
      borderRadius: BorderRadius.circular(3),
      linearMinHeight: 6,
      color: cs.primary,
      linearTrackColor: cs.surfaceContainerHighest,
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────

  /// Returns black or white text depending on which contrasts best with [color].
  static Color _contrastingTextColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.45 ? const Color(0xFF1A1A1A) : Colors.white;
  }

  /// Bumps lightness for dark mode if the primary color is too dark to see
  /// against dark surfaces.
  static Color _adjustForDarkMode(Color color) {
    final hsl = HSLColor.fromColor(color);
    if (hsl.lightness < 0.4) {
      return hsl.withLightness(0.55).toColor();
    }
    return color;
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
