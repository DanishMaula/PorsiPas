import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Konfigurasi tipografi PorsiPas menggunakan `Plus Jakarta Sans`.
abstract final class AppTypography {
  static const List<String> _fallbackFonts = <String>[
    'Roboto',
    'SF Pro Text',
    'sans-serif',
  ];

  static TextTheme buildTextTheme({bool useGoogleFonts = true}) {
    const base = TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.2,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.35,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: AppColors.textSecondary,
        fontFamilyFallback: _fallbackFonts,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.textPrimary,
        fontFamilyFallback: _fallbackFonts,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.textSecondary,
        fontFamilyFallback: _fallbackFonts,
      ),
    );

    if (!useGoogleFonts) {
      return base;
    }

    return GoogleFonts.plusJakartaSansTextTheme(base);
  }
}
