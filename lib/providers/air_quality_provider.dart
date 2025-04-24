import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/services/api_helper.dart';

final currentAirQualityProvider = FutureProvider.autoDispose(
  (ref) => ApiHelper.getAirQuality(),
);
