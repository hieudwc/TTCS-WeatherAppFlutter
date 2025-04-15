import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

List<Color> nightGradient = [
  AppColors.black,
  AppColors.secondaryBlack,
  AppColors.secondaryBlack.withOpacity(.95),
  AppColors.darkBlue,
  AppColors.accentBlue,
  AppColors.lightBlue,
];

List<Color> dayGradient = [
  Colors.lightBlue.shade100,
  Colors.lightBlue.shade200,
  Colors.lightBlue.shade300,
  Colors.blue.shade300,
  Colors.white,
];
