import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import '/providers/language_provider.dart';
import '/views/gradient_container.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGradient = ref.watch(backgroundGradientProvider);
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);

    return GradientContainer(
      gradientColors: currentGradient,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height - 150,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Localization(language: currentLanguage)
                    .translate('Settings', currentLanguage),
                style: const TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // 🔘 Toggle night mode
              _buildSettingButton(
                context,
                onPressed: () => toggleGradient(ref),
                icon: isNightMode ? Icons.light_mode : Icons.dark_mode,
                iconColor: isNightMode ? Colors.amber : Colors.blueGrey,
                label: Localization(language: currentLanguage).translate(
                    isNightMode ? 'Day Mode' : 'Night Mode', currentLanguage),
                bgColor: isNightMode
                    ? Colors.blueGrey.shade700
                    : Colors.lightBlue.shade100,
                textColor: isNightMode ? Colors.white : Colors.black87,
              ),

              const SizedBox(height: 20),

              // 🌐 Toggle language
              _buildSettingButton(
                context,
                onPressed: () {
                  ref.read(languageProvider.notifier).state =
                      currentLanguage == AppLanguage.en
                          ? AppLanguage.vn
                          : AppLanguage.en;
                },
                icon: Icons.language,
                iconColor: Colors.deepPurple,
                label: currentLanguage == AppLanguage.en
                    ? 'Chuyển sang Tiếng Việt'
                    : 'Switch to English',
                bgColor: Colors.purple.shade100,
                textColor: Colors.black87,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingButton(
    BuildContext context, {
    required VoidCallback onPressed,
    required IconData icon,
    required Color iconColor,
    required String label,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor, size: 28),
        label: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
