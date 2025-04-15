import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/views/famous_cities_weather.dart';
import '/views/gradient_container.dart';
import '/widgets/round_text_field.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentGradient = ref.watch(backgroundGradientProvider);
    final isNightMode = ref.watch(isNightModeProvider);
    return GradientContainer(
      gradientColors: currentGradient,
      children: [
        // Page title
        Align(
          alignment: Alignment.center,
          child: Text(
            'Pick Location',
            style: isNightMode ? TextStyles.h1NightMode : TextStyles.h1DayMode,
          ),
        ),

        const SizedBox(height: 20),

        // Page subtitle
        Text(
          'Find the area or city that you want to know the detailed weather info at this time',
          style: isNightMode
              ? TextStyles.subtitleTextNightMode
              : TextStyles.subtitleTextDayMode,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        // Pick location row
        const Row(
          children: [
            // Choose city text field
            Expanded(
              child: RoundTextField(),
            ),
            SizedBox(width: 15),

            LocationIcon(),
          ],
        ),

        const SizedBox(height: 30),

        const FamousCitiesWeather(),
      ],
    );
  }
}

class LocationIcon extends ConsumerWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: isNightMode ? AppColors.accentBlue : AppColors.lightBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.location_on_outlined,
        color: isNightMode ? AppColors.white : AppColors.grey,
      ),
    );
  }
}
