import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/constants/app_colors.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/constants/text_styles.dart';
import 'package:weather_app_tutorial/models/air_quality.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import 'package:weather_app_tutorial/providers/background_color_provider.dart';
import 'package:weather_app_tutorial/providers/air_quality_provider.dart';

class AirQualityWidget extends ConsumerWidget {
  const AirQualityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);
    final airQualityData = ref.watch(currentAirQualityProvider);

    return airQualityData.when(
      data: (airQualityModel) {
        if (airQualityModel.list.isEmpty) {
          return const SizedBox.shrink();
        }

        final aqiData = airQualityModel.list.first;
        return _buildAirQualityContent(
            context, aqiData, isNightMode, currentLanguage);
      },
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }

  Widget _buildAirQualityContent(
      BuildContext context,
      AirQualityData airQualityData,
      bool isNightMode,
      AppLanguage currentLanguage) {
    // Lấy thông tin về chỉ số AQI
    Color aqiColor;

    // Chuyển đổi mã màu hex sang Color
    switch (airQualityData.main.aqi) {
      case 1:
        aqiColor = Colors.green;
        break;
      case 2:
        aqiColor = Colors.yellow;
        break;
      case 3:
        aqiColor = Colors.orange;
        break;
      case 4:
        aqiColor = Colors.red;
        break;
      case 5:
        aqiColor = Colors.purple;
        break;
      default:
        aqiColor = Colors.grey;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Tiêu đề phần chất lượng không khí
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Localization(language: currentLanguage)
                  .translate('Air Quality', currentLanguage),
              style:
                  isNightMode ? TextStyles.h2NightMode : TextStyles.h2DayMode,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _AirQualityDetailsScreen(
                        airQualityData: airQualityData),
                  ),
                );
              },
              child: Text(
                Localization(language: currentLanguage)
                    .translate('See Details', currentLanguage),
                style: const TextStyle(
                  color: AppColors.lightBlue,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Hiển thị chỉ số AQI chính
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: aqiColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: aqiColor,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              // Hiển thị chỉ số AQI trong vòng tròn
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: aqiColor.withOpacity(0.3),
                  border: Border.all(
                    color: aqiColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${airQualityData.main.aqi}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: aqiColor,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Mô tả về chất lượng không khí
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localization(language: currentLanguage).translate(
                          airQualityData.main.getAqiDescription(),
                          currentLanguage),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: aqiColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getShortHealthDescription(
                          airQualityData.main.aqi, currentLanguage),
                      style: TextStyle(
                        fontSize: 14,
                        color: isNightMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getShortHealthDescription(int aqi, AppLanguage language) {
    switch (aqi) {
      case 1:
        return Localization(language: language)
            .translate("Air quality is good", language);
      case 2:
        return Localization(language: language)
            .translate("Air quality is acceptable", language);
      case 3:
        return Localization(language: language)
            .translate("Sensitive groups may experience effects", language);
      case 4:
        return Localization(language: language)
            .translate("Everyone may experience health effects", language);
      case 5:
        return Localization(language: language)
            .translate("Health alert: everyone may be affected", language);
      default:
        return Localization(language: language)
            .translate("No data available", language);
    }
  }
}

class _AirQualityDetailsScreen extends ConsumerWidget {
  final AirQualityData airQualityData;

  const _AirQualityDetailsScreen({
    required this.airQualityData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNightMode = ref.watch(isNightModeProvider);
    final currentLanguage = ref.watch(languageProvider);
    final currentGradient = ref.watch(backgroundGradientProvider);

    // Lấy thông tin về chỉ số AQI
    Color aqiColor;

    // Chuyển đổi mã màu hex sang Color
    switch (airQualityData.main.aqi) {
      case 1:
        aqiColor = Colors.green;
        break;
      case 2:
        aqiColor = Colors.yellow;
        break;
      case 3:
        aqiColor = Colors.orange;
        break;
      case 4:
        aqiColor = Colors.red;
        break;
      case 5:
        aqiColor = Colors.purple;
        break;
      default:
        aqiColor = Colors.grey;
    }

    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: currentGradient.first.withOpacity(0.9),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: isNightMode ? Colors.white : AppColors.accentBlue,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            Localization(language: currentLanguage)
                .translate('Air Quality', currentLanguage),
            style: TextStyle(
              color: isNightMode ? Colors.white : AppColors.accentBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2),
            child: Container(
              height: 2,
              color: Colors.red.withOpacity(0.7),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: currentGradient,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Tiêu đề phần chất ô nhiễm
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Text(
                Localization(language: currentLanguage)
                    .translate('Pollutants', currentLanguage),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isNightMode ? Colors.white : AppColors.accentBlue,
                ),
              ),
            ),

            // Widget hiển thị chi tiết các thành phần
            _buildComponentItem(
                'CO',
                '${airQualityData.components.co.toStringAsFixed(2)} μg/m³',
                isNightMode),
            _buildComponentItem(
                'NO₂',
                '${airQualityData.components.no2.toStringAsFixed(2)} μg/m³',
                isNightMode),
            _buildComponentItem(
                'O₃',
                '${airQualityData.components.o3.toStringAsFixed(2)} μg/m³',
                isNightMode),
            _buildComponentItem(
                'PM2.5',
                '${airQualityData.components.pm2_5.toStringAsFixed(2)} μg/m³',
                isNightMode),
            _buildComponentItem(
                'PM10',
                '${airQualityData.components.pm10.toStringAsFixed(2)} μg/m³',
                isNightMode),
            _buildComponentItem(
                'SO₂',
                '${airQualityData.components.so2.toStringAsFixed(2)} μg/m³',
                isNightMode),

            const SizedBox(height: 20),

            // Thông tin về chỉ số AQI
            _buildAqiInfoCard(isNightMode, currentLanguage),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentItem(String name, String value, bool isNightMode) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isNightMode ? Colors.black26 : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isNightMode ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isNightMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAqiInfoCard(bool isNightMode, AppLanguage currentLanguage) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNightMode ? Colors.black26 : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AQI Levels",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isNightMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          _buildAqiLevelRow("1 - Good", Colors.green, isNightMode),
          _buildAqiLevelRow("2 - Fair", Colors.yellow, isNightMode),
          _buildAqiLevelRow("3 - Moderate", Colors.orange, isNightMode),
          _buildAqiLevelRow("4 - Poor", Colors.red, isNightMode),
          _buildAqiLevelRow("5 - Very Poor", Colors.purple, isNightMode),
        ],
      ),
    );
  }

  Widget _buildAqiLevelRow(String text, Color color, bool isNightMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isNightMode ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
