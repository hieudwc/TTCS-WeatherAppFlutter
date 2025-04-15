import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';

import '/constants/app_colors.dart';
import '/screens/forecast_report_screen.dart';
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
    ForecastReportScreen(),
    SettingsScreen(),
  ];

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
              icon: Icon(Icons.wb_sunny_outlined, color: iconColor),
              selectedIcon: Icon(Icons.wb_sunny, color: selectedIconColor),
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
