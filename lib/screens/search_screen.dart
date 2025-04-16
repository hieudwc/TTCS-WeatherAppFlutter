import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/models/weather.dart';
import '/services/api_helper.dart';
import '/views/famous_cities_weather.dart';
import '/views/gradient_container.dart';
import '/widgets/round_text_field.dart';
import '/screens/weather_detail_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _searchController;
  bool _isSearching = false;
  Weather? _searchResult;
  String? _searchError;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _isSearching = false;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Hàm tìm kiếm thời tiết theo tên thành phố
  Future<void> _searchWeatherByCity() async {
    final cityName = _searchController.text.trim();
    if (cityName.isEmpty) {
      setState(() {
        _searchError = 'Please enter city name';
        _isSearching = false;
        _searchResult = null;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchError = null;
      _searchResult = null;
    });

    try {
      final result = await ApiHelper.getWeatherByCityName(cityName: cityName);
      setState(() {
        _searchResult = result;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _searchError = 'City not found. Please try again.';
        _isSearching = false;
      });
    }
  }

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
                .translate('Search', currentLanguage),
            style: isNightMode ? TextStyles.h1NightMode : TextStyles.h1DayMode,
          ),
        ),

        const SizedBox(height: 20),

        // Page subtitle
        Text(
          Localization(language: currentLanguage).translate(
              'Enter the city name to view weather information',
              currentLanguage),
          style: isNightMode
              ? TextStyles.subtitleTextNightMode
              : TextStyles.subtitleTextDayMode,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        // Pick location row
        Row(
          children: [
            // Choose city text field
            Expanded(
              child: RoundTextField(
                controller: _searchController,
              ),
            ),
            const SizedBox(width: 15),

            // Location icon button
            LocationIcon(
              onPressed: _searchWeatherByCity,
            ),
          ],
        ),

        const SizedBox(height: 30),

        // Hiển thị kết quả tìm kiếm hoặc danh sách các thành phố đã định nghĩa
        if (_isSearching)
          const Center(
            child: CircularProgressIndicator(),
          )
        else if (_searchError != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _searchError!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else if (_searchResult != null)
          SearchResultWidget(
            weather: _searchResult!,
            isNightMode: isNightMode,
          )
        else
          const FamousCitiesWeather(),
      ],
    );
  }
}

class LocationIcon extends StatelessWidget {
  final VoidCallback onPressed;

  const LocationIcon({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: AppColors.accentBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.search,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  final Weather weather;
  final bool isNightMode;

  const SearchResultWidget({
    super.key,
    required this.weather,
    required this.isNightMode,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isNightMode ? Colors.white : Colors.black87;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => WeatherDetailScreen(
              cityName: weather.name,
            ),
          ),
        );
      },
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.sys.country,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                  width: 80,
                  height: 80,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.thermostat_outlined,
                      color: textColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${weather.main.temp.toStringAsFixed(1)}°C',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  weather.weather[0].description,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildWeatherInfo(
                  Icons.water_drop_outlined,
                  '${weather.main.humidity}%',
                  'Độ ẩm',
                  textColor,
                ),
                _buildWeatherInfo(
                  Icons.air,
                  '${weather.wind.speed} m/s',
                  'Gió',
                  textColor,
                ),
                _buildWeatherInfo(
                  Icons.remove_red_eye_outlined,
                  '${weather.visibility ?? 0 / 1000} km',
                  'Tầm nhìn',
                  textColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(
    IconData icon,
    String value,
    String label,
    Color textColor,
  ) {
    return Column(
      children: [
        Icon(icon, color: textColor),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: textColor.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
