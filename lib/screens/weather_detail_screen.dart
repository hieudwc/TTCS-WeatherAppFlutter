import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import '/constants/text_styles.dart';
import '/extensions/datetime.dart';
import '/extensions/strings.dart';
import '/providers/get_city_forecast_provider.dart';
import '/screens/weather_screen/weather_info.dart';
import '/views/gradient_container.dart';

class WeatherDetailScreen extends ConsumerWidget {
  const WeatherDetailScreen({super.key, required this.cityName});

  final String cityName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch((cityForecastProvider(cityName)));
    final currentGradient = ref.watch(backgroundGradientProvider);
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);
    return Scaffold(
      body: weatherData.when(
        data: (weather) {
          return GradientContainer(
            gradientColors: currentGradient,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                    width: double.infinity,
                  ),
                  // Country name text
                  Text(
                    Localization(language: currentLanguage)
                        .translate(weather.name, currentLanguage),
                    style: isNightMode
                        ? TextStyles.h1NightMode
                        : TextStyles.h1DayMode,
                  ),

                  const SizedBox(height: 20),

                  // Today's date
                  Text(
                    '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                    style: isNightMode
                        ? TextStyles.subtitleTextNightMode
                        : TextStyles.subtitleTextDayMode,
                  ),

                  const SizedBox(height: 50),

                  // Weather icon big
                  SizedBox(
                    height: 300,
                    child: Image.asset(
                      'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Weather description
                  Text(
                    Localization(language: currentLanguage)
                        .translate(
                            weather.weather[0].description, currentLanguage)
                        .capitalize,
                    style: isNightMode
                        ? TextStyles.h2NightMode
                        : TextStyles.h2DayMode,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Weather info in a row
              WeatherInfo(weather: weather),

              const SizedBox(height: 15),
            ],
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text(
              'An error has occurred',
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
