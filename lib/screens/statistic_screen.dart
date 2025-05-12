import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/screens/historical_weather_screen.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/views/gradient_container.dart';

class StatisticScreen extends ConsumerStatefulWidget {
  const StatisticScreen({super.key});
  @override
  ConsumerState<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends ConsumerState<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    final currentGradient = ref.watch(backgroundGradientProvider);
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);

    return GradientContainer(
      gradientColors: currentGradient,
      children: [
        // Page title
        Align(
          alignment: Alignment.center,
          child: Text(
            Localization(language: currentLanguage)
                .translate('Weather Statistics', currentLanguage),
            style: isNightMode ? TextStyles.h1NightMode : TextStyles.h1DayMode,
          ),
        ),

        const SizedBox(height: 20),

        // Page subtitle
        Text(
          Localization(language: currentLanguage).translate(
              'View detailed weather statistics and historical data',
              currentLanguage),
          style: isNightMode
              ? TextStyles.subtitleTextNightMode
              : TextStyles.subtitleTextDayMode,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        // Statistics card
        _buildStatCard(
          title: Localization(language: currentLanguage)
              .translate('Historical Temperature', currentLanguage),
          description: Localization(language: currentLanguage).translate(
              'View temperature data for month in the past', currentLanguage),
          icon: Icons.analytics_outlined,
          isNightMode: isNightMode,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HistoricalWeatherScreen(),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // You can add more statistic cards here
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isNightMode,
    required VoidCallback onTap,
  }) {
    final textColor = isNightMode ? Colors.white : Colors.black87;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isNightMode ? AppColors.nightBlue : AppColors.dayBlue,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  icon,
                  size: 48,
                  color: textColor,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
