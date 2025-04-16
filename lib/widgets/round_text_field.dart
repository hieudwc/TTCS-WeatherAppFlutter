import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';

import '/constants/app_colors.dart';

class RoundTextField extends ConsumerWidget {
  const RoundTextField({
    super.key,
    this.controller,
    this.hintText = 'Search',
  });

  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: isNightMode ? AppColors.accentBlue : AppColors.lightBlue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        style: const TextStyle(
          color: AppColors.white,
        ),
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.grey,
          ),
          border: InputBorder.none,
          hintText: Localization(language: currentLanguage)
              .translate(hintText, currentLanguage),
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
