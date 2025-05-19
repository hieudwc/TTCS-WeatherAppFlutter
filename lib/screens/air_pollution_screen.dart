import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_tutorial/constants/localization.dart';
import 'package:weather_app_tutorial/models/historical_air.dart';
import 'package:weather_app_tutorial/providers/language_provider.dart';
import 'package:weather_app_tutorial/services/firebase_service.dart';

class AirPollutionScreen extends ConsumerStatefulWidget {
  const AirPollutionScreen({super.key});

  @override
  ConsumerState<AirPollutionScreen> createState() => _AirPollutionScreenState();
}

class _AirPollutionScreenState extends ConsumerState<AirPollutionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  List<HistoricalAir> _todayData = [];
  List<HistoricalAir> _yesterdayData = [];
  List<HistoricalAir> _tomorrowData = [];
  String _error = '';
  String _selectedPollutant = 'pm10';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadAirQualityData();
  }

  Future<void> _loadAirQualityData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // Get all data in parallel
      final results = await Future.wait([
        FirebaseService.getHistoricalAirData(),
        FirebaseService.getTodayAirData(),
        FirebaseService.getTomorrowAirData(),
        // FirebaseService.getTodayAirData(),
      ]);

      setState(() {
        _yesterdayData = results[0];
        _todayData = results[1];
        _tomorrowData = results[2];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Error loading air quality data: $e';
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          Localization(language: currentLanguage)
              .translate('Air Quality', currentLanguage),
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
            onPressed: _loadAirQualityData,
            tooltip: 'Refresh Data',
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
                Tab(
                    text: Localization(language: currentLanguage)
                        .translate('Yesterday', currentLanguage)),
                Tab(
                    text: Localization(language: currentLanguage)
                        .translate('Today', currentLanguage)),
                Tab(
                    text: Localization(language: currentLanguage)
                        .translate('Tomorrow', currentLanguage)),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Pollutant selector
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPollutantButton('PM10', 'pm10'),
                _buildPollutantButton('PM2.5', 'pm2_5'),
                _buildPollutantButton('O3', 'o3'),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: _isLoading
                ? _buildLoadingIndicator(currentLanguage)
                : _error.isNotEmpty
                    ? _buildErrorWidget(currentLanguage)
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          _buildAirQualityChart(
                              _yesterdayData, 'Yesterday', currentLanguage),
                          _buildAirQualityChart(
                              _todayData, 'Today', currentLanguage),
                          _buildAirQualityChart(
                              _tomorrowData, 'Tomorrow', currentLanguage),
                        ],
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollutantButton(String label, String value) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedPollutant == value,
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _selectedPollutant = value;
          });
        }
      },
      selectedColor: const Color(0xFF4299E1),
      labelStyle: TextStyle(
        color: _selectedPollutant == value ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLoadingIndicator(AppLanguage currentLanguage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFF4299E1)),
          const SizedBox(height: 16),
          Text(
            Localization(language: currentLanguage)
                .translate('Loading air quality data...', currentLanguage),
            style: const TextStyle(
              color: Color(0xFF718096),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(AppLanguage currentLanguage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline,
              size: 64, color: const Color(0xFFE53E3E).withOpacity(0.7)),
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
            onPressed: _loadAirQualityData,
            icon: const Icon(Icons.refresh),
            label: Text(
              Localization(language: currentLanguage)
                  .translate('Try Again', currentLanguage),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4299E1),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirQualityChart(
      List<HistoricalAir> data, String period, AppLanguage currentLanguage) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          'No data available for $period',
          style: const TextStyle(color: Color(0xFF718096)),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$period ${_selectedPollutant.toUpperCase()} Levels',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3748),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return _buildBarChart(
                  data,
                  constraints.maxWidth,
                  constraints.maxHeight,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(
      List<HistoricalAir> data, double availableWidth, double availableHeight) {
    if (data.isEmpty) return Container();

    double maxValue;
    switch (_selectedPollutant) {
      case 'pm10':
        maxValue = data.map((e) => e.pm10).reduce((a, b) => a > b ? a : b);
        break;
      case 'pm2_5':
        maxValue = data.map((e) => e.pm2_5).reduce((a, b) => a > b ? a : b);
        break;
      case 'o3':
        maxValue = data.map((e) => e.o3).reduce((a, b) => a > b ? a : b);
        break;
      default:
        maxValue = 0;
    }

    maxValue = (maxValue / 10).ceil() * 10.0;

    final barWidth = (availableWidth - 60) / data.length;
    const barPadding = 2.0;

    return Stack(
      children: [
        ..._buildYAxisLabels(maxValue, availableHeight - 40),
        ...data.asMap().entries.map((entry) {
          int index = entry.key;
          HistoricalAir item = entry.value;

          double value;
          switch (_selectedPollutant) {
            case 'pm10':
              value = item.pm10;
              break;
            case 'pm2_5':
              value = item.pm2_5;
              break;
            case 'o3':
              value = item.o3;
              break;
            default:
              value = 0;
          }

          double barHeight = (value / maxValue) * (availableHeight - 40);

          return Positioned(
            left: 50 + (index * barWidth),
            bottom: 25,
            width: barWidth - barPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    color: _getBarColor(value),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(3),
                      topRight: Radius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                _buildTimeLabel(item.dt),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  List<Widget> _buildYAxisLabels(double maxValue, double height) {
    List<Widget> labels = [];
    int steps = 5;
    double stepValue = maxValue / steps;

    for (int i = 0; i <= steps; i++) {
      double value = (stepValue * (steps - i));
      double y = height * (i / steps);

      labels.add(
        Positioned(
          left: 0,
          top: y - 35,
          child: Container(
            width: 45,
            child: Text(
              value.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      );
    }
    return labels;
  }

  Widget _buildTimeLabel(String dt) {
    DateTime timeStamp =
        DateTime.fromMillisecondsSinceEpoch(int.parse(dt) * 1000);
    String hour = "${timeStamp.hour.toString().padLeft(2, '0')}";

    return Text(
      hour,
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFF718096),
      ),
      textAlign: TextAlign.center,
    );
  }

  Color _getBarColor(double value) {
    if (value <= 50) return Colors.green;
    if (value <= 100) return Colors.yellow;
    if (value <= 150) return Colors.orange;
    if (value <= 200) return Colors.red;
    return Colors.purple;
  }
}
