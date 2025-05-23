import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/views/gradient_container.dart';
import '/views/hourly_forecast_view.dart';
import '/views/weekly_forecast_view.dart';

class ForecastReportScreen extends ConsumerWidget {
  const ForecastReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentGradient = ref.watch(backgroundGradientProvider);
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);
    return GradientContainer(
      gradientColors: currentGradient,
      children: [
        // Page Title
        Align(
          alignment: Alignment.center,
          child: Text(
            Localization(language: currentLanguage)
                .translate('Forecast Report', currentLanguage),
            style: isNightMode ? TextStyles.h1NightMode : TextStyles.h1DayMode,
          ),
        ),

        const SizedBox(height: 40),

        // Today's date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Localization(language: currentLanguage)
                  .translate('Today', currentLanguage),
              style:
                  isNightMode ? TextStyles.h2NightMode : TextStyles.h2DayMode,
            ),
            Text(
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
              style: isNightMode
                  ? TextStyles.subtitleTextNightMode
                  : TextStyles.subtitleTextDayMode,
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Today's forecast
        const HourlyForecastView(),

        const SizedBox(height: 20),

        // Next Forecast
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Localization(language: currentLanguage)
                  .translate('Next Forecast', currentLanguage),
              style:
                  isNightMode ? TextStyles.h2NightMode : TextStyles.h2DayMode,
            ),
            Icon(
              Icons.calendar_month_rounded,
              color: isNightMode ? AppColors.white : AppColors.accentBlue,
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Weekly forecast
        const WeeklyForecastView(),
      ],
    );
  }
}
