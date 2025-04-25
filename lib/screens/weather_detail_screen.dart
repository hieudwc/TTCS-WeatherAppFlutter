import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import 'package:weather_app_tutorial/services/city_preferences.dart';
import '/constants/text_styles.dart';

import '/extensions/strings.dart';
import '/providers/get_city_forecast_provider.dart';
import '/screens/weather_screen/weather_info.dart';
import '/views/gradient_container.dart';

class WeatherDetailScreen extends ConsumerStatefulWidget {
  const WeatherDetailScreen({super.key, required this.cityName});

  final String cityName;

  @override
  ConsumerState<WeatherDetailScreen> createState() =>
      _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends ConsumerState<WeatherDetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    // Kiểm tra xem thành phố có trong danh sách yêu thích không
    final savedCities = await CityPreferences.getSavedCities();
    setState(() {
      isFavorite = savedCities.contains(widget.cityName);
    });
  }

  Future<void> toggleFavorite() async {
    if (isFavorite) {
      // Nếu đã lưu, xóa khỏi danh sách
      await CityPreferences.removeCity(widget.cityName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('${widget.cityName} đã bị xóa khỏi danh sách yêu thích!'),
        ),
      );
    } else {
      // Nếu chưa lưu, thêm vào danh sách
      await CityPreferences.saveCity(widget.cityName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('${widget.cityName} đã được lưu vào danh sách yêu thích!'),
        ),
      );
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = ref.watch((cityForecastProvider(widget.cityName)));
    final currentGradient = ref.watch(backgroundGradientProvider);
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Nền và nội dung chính
          weatherData.when(
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
                      // Tên thành phố
                      Text(
                        Localization(language: currentLanguage)
                            .translate(weather.name, currentLanguage),
                        style: isNightMode
                            ? TextStyles.h1NightMode
                            : TextStyles.h1DayMode,
                      ),

                      const SizedBox(height: 20),

                      // Ngày hiện tại
                      Text(
                        '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
                        style: isNightMode
                            ? TextStyles.subtitleTextNightMode
                            : TextStyles.subtitleTextDayMode,
                      ),

                      const SizedBox(height: 50),

                      // Icon thời tiết lớn
                      SizedBox(
                        height: 300,
                        child: Image.asset(
                          'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Mô tả thời tiết
                      Text(
                        Localization(language: currentLanguage)
                            .translate(
                                weather.weather[0].description, currentLanguage)
                            .capitalize,
                        style: isNightMode
                            ? TextStyles.h2NightMode
                            : TextStyles.h2DayMode,
                      ),

                      const SizedBox(height: 40),

                      // Thông tin thời tiết
                      WeatherInfo(weather: weather),

                      const SizedBox(height: 15),
                    ],
                  ),
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

          // Nút trái tim
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
