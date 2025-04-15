import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/widgets/gradients.dart';
import 'package:flutter/material.dart';

// A provider to manage which gradient is currently selected
final backgroundGradientProvider = StateProvider<List<Color>>((ref) {
  // Default to night gradient
  return nightGradient;
});

// A provider to check if currently using night gradient
final isNightModeProvider = Provider<bool>((ref) {
  final currentGradient = ref.watch(backgroundGradientProvider);
  return currentGradient == nightGradient;
});

// Function to toggle between day and night gradients
void toggleGradient(WidgetRef ref) {
  final currentGradient = ref.read(backgroundGradientProvider);

  if (currentGradient == nightGradient) {
    ref.read(backgroundGradientProvider.notifier).state = dayGradient;
  } else {
    ref.read(backgroundGradientProvider.notifier).state = nightGradient;
  }
}
