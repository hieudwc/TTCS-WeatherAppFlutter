import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';

import '../providers/background_color_provider.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/extensions/datetime.dart';
import '/providers/get_weekly_forecast_provider.dart';
import '/utils/get_weather_icons.dart';
import '/widgets/subscript_text.dart';

class WeeklyForecastView extends ConsumerWidget {
  const WeeklyForecastView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    final weeklyForecast = ref.watch(weeklyForecastProvider);

    return weeklyForecast.when(
      data: (weatherData) {
        return ListView.builder(
          itemCount: weatherData.daily.weatherCode.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final dayOfWeek = Localization(language: currentLanguage).translate(
                DateTime.parse(weatherData.daily.time[index]).dayOfWeek,
                currentLanguage);
            final date = weatherData.daily.time[index];
            final temp = weatherData.daily.temperature2mMax[index];
            final icon = weatherData.daily.weatherCode[index];

            return WeeklyForecastTile(
              date: date,
              day: dayOfWeek,
              icon: getWeatherIcon2(icon),
              temp: temp.round(),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class WeeklyForecastTile extends ConsumerWidget {
  const WeeklyForecastTile({
    super.key,
    required this.day,
    required this.date,
    required this.temp,
    required this.icon,
  });

  final String day;
  final String date;
  final int temp;
  final String icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isNightMode ? AppColors.nightBlue : AppColors.dayBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                day,
                style:
                    isNightMode ? TextStyles.h3NightMode : TextStyles.h3DayMode,
              ),
              const SizedBox(height: 5),
              Text(
                date,
                style: isNightMode
                    ? TextStyles.subtitleTextNightMode
                    : TextStyles.subtitleTextDayMode,
              ),
            ],
          ),

          // Temperature
          SuperscriptText(
            text: '$temp',
            color: AppColors.white,
            superScript: '°C',
            superscriptColor: AppColors.white,
          ),

          // weather icon
          Image.asset(
            icon,
            width: 60,
          ),
        ],
      ),
    );
  }
}
