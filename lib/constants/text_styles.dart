import 'package:flutter/material.dart';

import '/constants/app_colors.dart';

@immutable
class TextStyles {
  static const h1NightMode = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const h1DayMode = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.accentBlue,
  );

  static const h2NightMode = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const h2DayMode = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.accentBlue,
  );

  static const h3NightMode = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const h3DayMode = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.accentBlue,
  );

  static const subtitleTextNightMode = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static const subtitleTextDayMode = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.accentBlue,
  );

  static const largeSubtitleNightMode = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );

  static const largeSubtitleDayMode = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.accentBlue,
  );
}
