import 'package:flutter/material.dart';

class AppColors {
  // Светлая тема - чистая, не кричащая
  static const Color bg         = Color(0xFFF8F7F4);   // тёплый белый
  static const Color surface    = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF2F1EE);   // светло-серый

  static const Color accent     = Color(0xFF2D6BE4);   // спокойный синий
  static const Color accentLight= Color(0xFFEBF1FC);
  static const Color accentText = Color(0xFF1A4DB8);

  static const Color textPrimary  = Color(0xFF1A1A2E);
  static const Color textSecondary= Color(0xFF5A5A72);
  static const Color textMuted    = Color(0xFF9B9BAA);

  static const Color border     = Color(0xFFE5E4E0);
  static const Color borderHover= Color(0xFFB8CBEF);

  static const Color tagBg      = Color(0xFFF0F0F5);
  static const Color tagText    = Color(0xFF4A4A62);

  // Тэги навыков
  static const Color sqlColor     = Color(0xFF0F7B6C);
  static const Color sqlBg        = Color(0xFFE6F5F3);
  static const Color pythonColor  = Color(0xFF4B6BFB);
  static const Color pythonBg     = Color(0xFFECF0FE);
  static const Color ampColor     = Color(0xFFB45309);
  static const Color ampBg        = Color(0xFFFEF3E2);
}

class AppTextStyles {
  static TextStyle heading1 = const TextStyle(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static TextStyle heading2 = const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.3,
  );

  static TextStyle heading3 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle body = const TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.6,
  );

  static TextStyle label = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    color: AppColors.accent,
  );
}

class AppSpacing {
  static const double sectionV  = 80.0;
  static const double contentH  = 24.0;
  static const double maxWidth  = 1100.0;
}
