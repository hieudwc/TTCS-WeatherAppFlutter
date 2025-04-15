import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';

import '/constants/app_colors.dart';

class RoundTextField extends ConsumerWidget {
  const RoundTextField({
    super.key,
    this.controller,
  });

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
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
        decoration: const InputDecoration(
          fillColor: Colors.white,
          focusColor: Colors.white,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.grey,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
