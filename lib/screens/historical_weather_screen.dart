import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/models/historical_weather.dart';
import 'package:weather_app_tutorial/services/firebase_service.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';

class HistoricalWeatherScreen extends ConsumerStatefulWidget {
  const HistoricalWeatherScreen({super.key});

  @override
  ConsumerState<HistoricalWeatherScreen> createState() =>
      _HistoricalWeatherScreenState();
}

class _HistoricalWeatherScreenState
    extends ConsumerState<HistoricalWeatherScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<HistoricalWeather> _lastData2 = [];
  List<HistoricalWeather> _lastData1 = [];
  List<HistoricalWeather> _presentData = [];
  String _error = '';

  // Helper function to get the English month name from number
  String getMonthName(int monthNumber) {
    final Map<int, String> monthNames = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };
    return monthNames[monthNumber] ?? 'Unknown';
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadHistoricalData();
  }

  Future<void> _loadHistoricalData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final lastMonthData2 = await FirebaseService.getHistoricalData2();
      final lastMonthData1 = await FirebaseService.getHistoricalData1();
      final presentData = await FirebaseService.getCurrentMonthHistoricalData();

      setState(() {
        _lastData2 = lastMonthData2;
        _lastData1 = lastMonthData1;
        _presentData = presentData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading weather data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguage = ref.watch(languageProvider);

    // Get month names dynamically for tabs, or use defaults if data is not loaded yet
    final String tab1Month = _lastData2.isNotEmpty
        ? Localization(language: currentLanguage).translate(
            getMonthName(_lastData2.first.date.month), currentLanguage)
        : '...';

    final String tab2Month = _lastData1.isNotEmpty
        ? Localization(language: currentLanguage).translate(
            getMonthName(_lastData1.first.date.month), currentLanguage)
        : '...';

    final String tab3Month = Localization(language: currentLanguage)
        .translate('Present', currentLanguage);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Localization(language: currentLanguage)
              .translate('Historical Weather', currentLanguage),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Color(0xFF2D3748),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF4299E1)),
            onPressed: _loadHistoricalData,
            tooltip: Localization(language: currentLanguage)
                .translate('Refresh Data', currentLanguage),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFEDF2F7),
                  width: 1.0,
                ),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF4299E1),
              unselectedLabelColor: const Color(0xFFA0AEC0),
              indicatorColor: const Color(0xFF4299E1),
              indicatorWeight: 3.0,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: tab1Month),
                Tab(text: tab2Month),
                Tab(text: tab3Month),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFF4299E1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Localization(language: currentLanguage)
                        .translate('Loading weather data...', currentLanguage),
                    style: TextStyle(
                      color: const Color(0xFF718096),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          : _error.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_off,
                        size: 64,
                        color: const Color(0xFFE53E3E).withOpacity(0.7),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _error,
                        style: const TextStyle(
                          color: Color(0xFFE53E3E),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _loadHistoricalData,
                        icon: const Icon(Icons.refresh),
                        label: Text(
                          Localization(language: currentLanguage)
                              .translate('Try Again', currentLanguage),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4299E1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  color: const Color(0xFF4299E1),
                  onRefresh: _loadHistoricalData,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildMonthChart(_lastData2, tab1Month, currentLanguage),
                      _buildMonthChart(_lastData1, tab2Month, currentLanguage),
                      _buildMonthChart(_presentData, tab3Month, currentLanguage)
                    ],
                  ),
                ),
    );
  }

  Widget _buildMonthChart(
      List<HistoricalWeather> data, String month, AppLanguage currentLanguage) {
    if (data.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Color(0xFFA0AEC0),
            ),
            const SizedBox(height: 16),
            Text(
              '${Localization(language: currentLanguage).translate('No data available for', currentLanguage)} $month',
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF718096),
              ),
            ),
          ],
        ),
      );
    }

    // Get the month number for this dataset
    final int monthNumber = data.first.date.month;
    final String monthName = Localization(language: currentLanguage)
        .translate(getMonthName(monthNumber), currentLanguage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.thermostat,
                        color: Color(0xFF4299E1),
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Localization(language: currentLanguage)
                            .translate('TEMPERATURE CHART', currentLanguage),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          color: Color(0xFF2D3748),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF8FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      '°C',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4299E1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${Localization(language: currentLanguage).translate('Daily temperature data for', currentLanguage)} $monthName 2025',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF718096),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomTemperatureChart(
            data: data,
            currentLanguage: currentLanguage,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, -2),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Localization(language: currentLanguage).translate('$monthName', currentLanguage)} - 2025',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _buildLegendItem('TB cao', Colors.red, isLine: true),
                  _buildLegendItem('TB thấp', const Color(0xFF3182CE),
                      isLine: true),
                  _buildLegendItem('Thực cao', const Color(0xFFFF8A00)),
                  _buildLegendItem('Thực thấp', const Color(0xFF42A5F5)),
                  _buildLegendItem('Dự báo cao', const Color(0xFFFBD38D)),
                  _buildLegendItem('Dự báo thấp', const Color(0xFFBEE3F8)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, {bool isLine = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isLine
            ? Container(
                width: 18,
                height: 2,
                color: color,
              )
            : Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: isLine ? null : BorderRadius.circular(2),
                ),
              ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF718096),
          ),
        ),
      ],
    );
  }
}

class CustomTemperatureChart extends StatelessWidget {
  final List<HistoricalWeather> data;
  final AppLanguage currentLanguage;

  const CustomTemperatureChart({
    Key? key,
    required this.data,
    required this.currentLanguage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort and prepare data
    final sortedData = List<HistoricalWeather>.from(data)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Find max and min values for scaling
    double maxTemp =
        sortedData.map((e) => e.maxTemp).reduce((a, b) => a > b ? a : b);
    double minTemp =
        sortedData.map((e) => e.minTemp).reduce((a, b) => a < b ? a : b);

    // Add padding to the max and min values
    maxTemp = ((maxTemp ~/ 4) + 1) * 4.0; // Round up to nearest multiple of 4
    minTemp = ((minTemp ~/ 4)) * 4.0; // Round down to nearest multiple of 4

    // Calculate the temperature range
    double tempRange = maxTemp - minTemp;

    // Calculate average temperature lines
    double avgMax = sortedData.map((e) => e.maxTemp).reduce((a, b) => a + b) /
        sortedData.length;
    double avgMin = sortedData.map((e) => e.minTemp).reduce((a, b) => a + b) /
        sortedData.length;

    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double chartWidth = constraints.maxWidth;
          double chartHeight = constraints.maxHeight;

          // Adjust bar width for even spacing, accounting for the temperature column
          double barSpacing = 8.0; // Fixed spacing between bars
          double barWidth = 16.0; // Fixed bar width
          double totalBarWidth =
              barWidth + barSpacing; // Total width per day (bar + spacing)

          // Calculate total width needed for all bars
          double totalContentWidth = sortedData.length * totalBarWidth +
              80; // Extra space for temperature column

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: math.max(totalContentWidth, chartWidth),
              height: chartHeight,
              padding: const EdgeInsets.only(
                top: 30,
                right: 20,
                left: 60, // Increased left padding for temperature column
                bottom: 60,
              ),
              child: Stack(
                children: [
                  // Draw horizontal grid lines
                  ..._buildGridLines(minTemp, maxTemp, chartHeight - 90),

                  // Draw y-axis line (temperature scale line)
                  Positioned(
                    left: 20, // Adjusted to align with temperature labels
                    top: 0,
                    bottom: 60,
                    child: Container(
                      width: 1,
                      color: Colors.grey[300],
                    ),
                  ),

                  // Draw temperature bars and date labels
                  ...sortedData.asMap().entries.map((entry) {
                    int index = entry.key;
                    HistoricalWeather weather = entry.value;

                    double x = 30 +
                        index *
                            totalBarWidth; // Adjusted for temperature column
                    double height = chartHeight - 90;

                    // Calculate bar heights
                    double maxBarHeight = _getBarHeight(
                        weather.maxTemp, minTemp, tempRange, height);
                    double minBarHeight = _getBarHeight(
                        weather.minTemp, minTemp, tempRange, height);

                    return Stack(
                      children: [
                        // Bar container
                        Positioned(
                          left: x,
                          bottom: 60,
                          child: Column(
                            children: [
                              // Upper bar (orange)
                              Container(
                                width: barWidth,
                                height: maxBarHeight - minBarHeight,
                                color: const Color(0xFFFF8A00),
                              ),
                              // Lower bar (blue)
                              Container(
                                width: barWidth,
                                height: minBarHeight,
                                color: const Color(0xFF42A5F5),
                              ),
                            ],
                          ),
                        ),

                        // Date and weekday labels at bottom
                        Positioned(
                          left: x - barWidth * 0.5,
                          bottom: 30,
                          child: SizedBox(
                            width: barWidth * 2,
                            child: Text(
                              DateFormat('d').format(weather.date),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        // Weekday number below the date
                        Positioned(
                          left: x - barWidth * 0.5,
                          bottom: 10,
                          child: SizedBox(
                            width: barWidth * 2,
                            child: Text(
                              _getDayOfWeek(weather.date.weekday),
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),

                  // Draw average temperature lines
                  Positioned(
                    left: 20,
                    right: 0,
                    bottom: 60 +
                        _getBarHeight(
                            avgMax, minTemp, tempRange, chartHeight - 90),
                    child: Container(
                      height: 1,
                      color: Colors.red.withOpacity(0.8),
                    ),
                  ),

                  Positioned(
                    left: 20,
                    right: 0,
                    bottom: 60 +
                        _getBarHeight(
                            avgMin, minTemp, tempRange, chartHeight - 90),
                    child: Container(
                      height: 1,
                      color: const Color(0xFF3182CE).withOpacity(0.8),
                    ),
                  ),

                  // Y-axis labels with clearer styling
                  ..._buildYAxisLabels(minTemp, maxTemp, chartHeight - 90),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return '2';
      case 2:
        return '3';
      case 3:
        return '4';
      case 4:
        return '5';
      case 5:
        return '6';
      case 6:
        return '7';
      case 7:
        return 'CN';
      default:
        return '';
    }
  }

  List<Widget> _buildGridLines(double minTemp, double maxTemp, double height) {
    List<Widget> gridLines = [];

    int steps = ((maxTemp - minTemp) / 4).ceil();

    for (int i = 0; i <= steps; i++) {
      double temp = minTemp + (i * 4);
      double y =
          height - _getBarHeight(temp, minTemp, maxTemp - minTemp, height);

      if (i > 0) {
        gridLines.add(
          Positioned(
            left: 20,
            top: y,
            right: 0,
            child: Container(
              height: 1,
              color: const Color(0xFFE2E8F0),
            ),
          ),
        );
      }
    }

    return gridLines;
  }

  List<Widget> _buildYAxisLabels(
      double minTemp, double maxTemp, double height) {
    List<Widget> labels = [];

    int steps = ((maxTemp - minTemp) / 4).ceil();

    for (int i = 0; i <= steps; i++) {
      double temp = minTemp + (i * 4);
      double y =
          height - _getBarHeight(temp, minTemp, maxTemp - minTemp, height) - 70;

      labels.add(
        Positioned(
          left: -25,
          top: y,
          child: Container(
            width: 50,
            height: 20,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              '${temp.toInt()}°',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF2D3748),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      );
    }

    return labels;
  }

  double _getBarHeight(
      double temp, double minTemp, double tempRange, double availableHeight) {
    return ((temp - minTemp) / tempRange) * availableHeight;
  }
}
