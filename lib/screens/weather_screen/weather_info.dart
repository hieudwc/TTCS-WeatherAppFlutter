import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';

import '/constants/text_styles.dart';
import '/extensions/double.dart';
import '/models/weather.dart';

// class WeatherInfo extends StatelessWidget {
//   const WeatherInfo({
//     super.key,
//     required this.weather,
//   });

//   final Weather weather;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 30,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           WeatherInfoTile(
//             title: 'Temp',
//             value: '${weather.main.temp}°',
//           ),
//           WeatherInfoTile(
//             title: 'Wind',
//             value: '${weather.wind.speed.kmh} km/h',
//           ),
//           WeatherInfoTile(
//             title: 'Humidity',
//             value: '${weather.main.humidity}%',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WeatherInfoTile extends StatelessWidget {
//   const WeatherInfoTile({
//     super.key,
//     required this.title,
//     required this.value,
//   }) : super();

//   final String title;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Title
//         Text(
//           title,
//           style: TextStyles.subtitleText,
//         ),
//         const SizedBox(height: 10),
//         Text(
//           value,
//           style: TextStyles.h3,
//         )
//       ],
//     );
//   }
// }
class WeatherInfo extends ConsumerWidget {
  const WeatherInfo({super.key, required this.weather});
  final Weather weather;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(languageProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherInfoTitle(
            title: Localization(language: currentLanguage)
                .translate('Temperature', currentLanguage),
            value: '${weather.main.temp}°',
          ),
          WeatherInfoTitle(
            title: Localization(language: currentLanguage)
                .translate('Wind', currentLanguage),
            value: '${weather.wind.speed.kmh} km/h',
          ),
          WeatherInfoTitle(
            title: Localization(language: currentLanguage)
                .translate('Humidity', currentLanguage),
            value: '${weather.main.humidity}%',
          ),
        ],
      ),
    );
  }
}

class WeatherInfoTitle extends ConsumerWidget {
  const WeatherInfoTitle({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
    return Column(
      children: [
        Text(
          title,
          style: isNightMode
              ? TextStyles.subtitleTextNightMode
              : TextStyles.subtitleTextDayMode,
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: isNightMode ? TextStyles.h3NightMode : TextStyles.h3DayMode,
        ),
      ],
    );
  }
}
