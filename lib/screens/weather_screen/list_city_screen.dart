import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/constants/text_styles.dart';
import 'package:weather_app_tutorial/screens/weather_detail_screen.dart';
import 'package:weather_app_tutorial/services/city_preferences.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/views/gradient_container.dart';

class SavedCitiesScreen extends ConsumerStatefulWidget {
  const SavedCitiesScreen({super.key});

  @override
  ConsumerState<SavedCitiesScreen> createState() => _SavedCitiesScreenState();
}

class _SavedCitiesScreenState extends ConsumerState<SavedCitiesScreen> {
  List<String> savedCities = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCities();
  }

  Future<void> _loadSavedCities() async {
    final cities = await CityPreferences.getSavedCities();
    setState(() {
      savedCities = cities;
    });
  }

  Future<void> _removeCity(String city) async {
    await CityPreferences.removeCity(city);
    _loadSavedCities();
  }

  @override
  Widget build(BuildContext context) {
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);
    final currentGradient = ref.watch(backgroundGradientProvider);

    return GradientContainer(
      gradientColors: currentGradient,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            Localization(language: currentLanguage)
                .translate('Favourite City', currentLanguage),
            style: isNightMode ? TextStyles.h1NightMode : TextStyles.h1DayMode,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: MediaQuery.of(context).size.height - 200, // Adjust as needed
          child: savedCities.isEmpty
              ? Center(
                  child: Text(
                    'Không có thành phố nào trong danh sách yêu thích.',
                    style: TextStyle(
                      fontSize: 16,
                      color: isNightMode ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: savedCities.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final city = savedCities[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isNightMode
                            ? Colors.black26
                            : Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        title: Text(
                          city,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isNightMode ? Colors.white : Colors.black87,
                          ),
                        ),
                        onTap: () {
                          // Chuyển đến trang chi tiết
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WeatherDetailScreen(cityName: city),
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => _removeCity(city),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
