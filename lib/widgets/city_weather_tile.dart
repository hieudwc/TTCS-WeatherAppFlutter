import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/models/famous_city.dart';
import '/providers/get_city_forecast_provider.dart';
import '/utils/get_weather_icons.dart';

class CityWeatherTile extends ConsumerWidget {
  const CityWeatherTile({
    super.key,
    required this.city,
    required this.index,
  });

  final FamousCity city;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(cityForecastProvider(city.name));
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);
    return currentWeather.when(
      data: (weather) {
        return Padding(
          padding: const EdgeInsets.all(
            0.0,
          ),
          child: Material(
            color: isNightMode
                ? (index == 0
                    ? AppColors.accentBlue
                    : const Color.fromARGB(255, 10, 71, 121))
                : (index == 0
                    ? AppColors.lightBlue
                    : const Color.fromARGB(255, 117, 182, 236)),
            elevation: index == 0 ? 12 : 0,
            borderRadius: BorderRadius.circular(25.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Row 1
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weather.main.temp.round()}°',
                              style: isNightMode
                                  ? TextStyles.h2NightMode
                                  : TextStyles.h2DayMode,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Localization(language: currentLanguage).translate(
                                  weather.weather[0].description,
                                  currentLanguage),
                              style: isNightMode
                                  ? TextStyles.subtitleTextNightMode
                                  : TextStyles.subtitleTextDayMode,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      // Row 2
                      Image.asset(
                        getWeatherIcon(weatherCode: weather.weather[0].id),
                        width: 50,
                      ),
                    ],
                  ),
                  Text(
                    weather.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
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
