import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/historical_weather.dart';
import '/services/api_helper.dart';

final currentMonthHistoricalProvider =
    FutureProvider.autoDispose<List<HistoricalWeather>>(
  (ref) => ApiHelper.getCurrentMonthHistoricalData(),
);

// Provider for past month historical data
final pastMonthHistoricalProvider =
    FutureProvider.autoDispose<List<HistoricalWeather>>(
  (ref) => ApiHelper.getHistoricalWeatherDataApi1(),
);

final pastMonthHistoricalProvider2 =
    FutureProvider.autoDispose<List<HistoricalWeather>>(
  (ref) => ApiHelper.getHistoricalWeatherDataApi1(),
);
