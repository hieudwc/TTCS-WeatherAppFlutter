import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/screens/statistic_screen.dart';
import 'package:weather_app_tutorial/screens/weather_screen/list_city_screen.dart';
import 'package:weather_app_tutorial/services/firebase_service.dart';

import '/constants/app_colors.dart';

import '/screens/search_screen.dart';
import '/screens/settings_screen.dart';
import 'weather_screen/weather_screen.dart';
import '/services/api_helper.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentPageIndex = 0;
  final _screens = const [
    WeatherScreen(),
    SearchScreen(),
    StatisticScreen(),
    SavedCitiesScreen(),
    SettingsScreen(),
  ];

  bool _isLoading = false;

  @override
  void initState() {
    ApiHelper.getCurrentWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isNightMode = ref.watch(isNightModeProvider);
    final backgroundColor = isNightMode
        ? AppColors.secondaryBlack
        : const Color.fromARGB(255, 151, 207, 228);
    final iconColor = isNightMode ? Colors.white : Colors.black87;
    final selectedIconColor = isNightMode ? Colors.lightBlue : Colors.blue;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: isNightMode ? AppColors.accentBlue : Colors.white,
        onPressed: _isLoading
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  // Show loading indicator
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đang lưu dữ liệu thời tiết...'),
                      duration: Duration(seconds: 1),
                    ),
                  );

                  // Calculate date range for debugging
                  final DateTime now = DateTime.now();
                  final DateTime endDate =
                      DateTime(now.year, now.month - 1, 30);
                  final DateTime startDate =
                      DateTime(now.year, now.month - 1, 1);
                  final String formattedStartDate =
                      startDate.toIso8601String().substring(0, 10);
                  final String formattedEndDate =
                      endDate.toIso8601String().substring(0, 10);

                  // Print URL for debugging
                  await ApiHelper.fetchLocation();
                  final debugUrl =
                      "https://archive-api.open-meteo.com/v1/archive?latitude=${ApiHelper.lat}&longitude=${ApiHelper.lon}&start_date=$formattedStartDate&end_date=$formattedEndDate&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=auto";
                  print("🔍 Historical Weather API URL: $debugUrl");

                  // Fetch historical weather data
                  final historicalData1 =
                      await ApiHelper.getHistoricalWeatherDataApi1();
                  final historicalData2 =
                      await ApiHelper.getHistoricalWeatherDataApi2();
                  final currentHistoricalData =
                      await ApiHelper.getCurrentMonthHistoricalData();
                  print("📊 Historical Data Count: ${historicalData1.length}");
                  if (historicalData1.isNotEmpty) {
                    print("📅 First date: ${historicalData1.first.date}");
                    print("📅 Last date: ${historicalData1.last.date}");
                  }
                  print('----------------------------');
                  print("📊 Historical Data Count: ${historicalData2.length}");
                  if (historicalData1.isNotEmpty) {
                    print("📅 First date: ${historicalData2.first.date}");
                    print("📅 Last date: ${historicalData2.last.date}");
                  }
                  print('----------------------------');
                  print(
                      "📊 Historical Data Count: ${currentHistoricalData.length}");
                  if (currentHistoricalData.isNotEmpty) {
                    print("📅 First date: ${historicalData2.first.date}");
                    print("📅 Last date: ${historicalData2.last.date}");
                  }
                  // Save to Firebase
                  await FirebaseService.saveLastMonthHistoricalData1(
                      historicalData1);
                  await FirebaseService.saveLastMonthHistoricalData2(
                      historicalData2);
                  await FirebaseService.saveCurrentMonthHistoricalData(
                      currentHistoricalData);
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Đã lưu dữ liệu thời tiết tháng 4 thành công!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  // Show error message
                  print("❌ Error: ${e.toString()}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Lỗi: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.cloud_upload),
      ),
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: backgroundColor,
        ),
        child: NavigationBar(
          selectedIndex: _currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) =>
              setState(() => _currentPageIndex = index),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: iconColor),
              selectedIcon: Icon(Icons.home, color: selectedIconColor),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined, color: iconColor),
              selectedIcon: Icon(Icons.search, color: selectedIconColor),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.analytics_outlined, color: iconColor),
              selectedIcon: Icon(Icons.analytics, color: selectedIconColor),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.location_city_outlined, color: iconColor),
              selectedIcon: Icon(Icons.location_city, color: selectedIconColor),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, color: iconColor),
              selectedIcon: Icon(Icons.settings, color: selectedIconColor),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
