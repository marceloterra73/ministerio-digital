import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle _base({
    required Color color,
    required double fontSize,
    FontWeight fontWeight = FontWeight.normal,
    double? height,
    letterSpacing,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  // Títulos
  static TextStyle h1 = _base(
    color: AppColors.textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle h2 = _base(
    color: AppColors.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.25,
  );

  static TextStyle h3 = _base(
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // Subtítulos
  static TextStyle subtitle1 = _base(
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static TextStyle subtitle2 = _base(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Corpo
  static TextStyle bodyLarge = _base(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle bodyMedium = _base(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle bodySmall = _base(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Capa / Labels
  static TextStyle labelLarge = _base(
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle labelMedium = _base(
    color: AppColors.textSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle labelSmall = _base(
    color: AppColors.textTertiary,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // Versículos (estilo especial)
  static TextStyle verse = GoogleFonts.merriweather(
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    height: 1.6,
  );

  static TextStyle verseReference = _base(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Botões
  static TextStyle buttonLarge = _base(
    color: AppColors.textOnPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle buttonMedium = _base(
    color: AppColors.textOnPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.3,
  );
}
