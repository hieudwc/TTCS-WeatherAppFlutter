import 'package:firebase_database/firebase_database.dart';
import 'package:weather_app_tutorial/models/historical_air.dart';
import 'package:weather_app_tutorial/models/historical_weather.dart';

class FirebaseService {
  static final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Save historical weather data to Firebase
  static Future<void> saveCurrentMonthHistoricalData(
      List<HistoricalWeather> weatherData) async {
    try {
      final DatabaseReference historyRef =
          _database.child('current_month_historical');

      // Create a batch update
      final Map<String, dynamic> updates = {};

      for (final weather in weatherData) {
        final String dateKey = weather.date.toIso8601String().substring(0, 10);
        updates[dateKey] = weather.toMap();
      }

      // Save all the data at once
      await historyRef.update(updates);
    } catch (e) {
      print('Error saving historical weather data: $e');
      rethrow;
    }
  }

  static Future<void> saveLastMonthHistoricalData1(
      List<HistoricalWeather> weatherData) async {
    try {
      final DatabaseReference historyRef =
          _database.child('historical_weather_1');

      // Create a batch update
      final Map<String, dynamic> updates = {};

      for (final weather in weatherData) {
        final String dateKey = weather.date.toIso8601String().substring(0, 10);
        updates[dateKey] = weather.toMap();
      }

      // Save all the data at once
      await historyRef.update(updates);
    } catch (e) {
      print('Error saving historical weather data: $e');
      rethrow;
    }
  }

  static Future<void> saveLastMonthHistoricalData2(
      List<HistoricalWeather> weatherData) async {
    try {
      final DatabaseReference historyRef =
          _database.child('historical_weather_2');

      // Create a batch update
      final Map<String, dynamic> updates = {};

      for (final weather in weatherData) {
        final String dateKey = weather.date.toIso8601String().substring(0, 10);
        updates[dateKey] = weather.toMap();
      }

      // Save all the data at once
      await historyRef.update(updates);
    } catch (e) {
      print('Error saving historical weather data: $e');
      rethrow;
    }
  }

  // Get historical weather data from Firebase for the current month
  static Future<List<HistoricalWeather>> getCurrentMonthHistoricalData() async {
    try {
      final DatabaseReference historyRef =
          _database.child('current_month_historical');
      final DataSnapshot snapshot = await historyRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            snapshot.value as Map<dynamic, dynamic>;
        final List<HistoricalWeather> weatherList = data.entries
            .map((entry) => HistoricalWeather.fromMap(
                Map<String, dynamic>.from(entry.value as Map)))
            .toList();

        // Sort the data by date
        weatherList.sort((a, b) => a.date.compareTo(b.date));
        return weatherList;
      }

      return [];
    } catch (e) {
      print('Error fetching historical weather data: $e');
      return [];
    }
  }

  // Get historical weather data for March
  static Future<List<HistoricalWeather>> getHistoricalData2() async {
    try {
      final DatabaseReference historyRef =
          _database.child('historical_weather_2');
      final DataSnapshot snapshot = await historyRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            snapshot.value as Map<dynamic, dynamic>;
        final List<HistoricalWeather> weatherList = data.entries
            .map((entry) => HistoricalWeather.fromMap(
                Map<String, dynamic>.from(entry.value as Map)))
            .toList();

        // Sort the data by date
        weatherList.sort((a, b) => a.date.compareTo(b.date));
        return weatherList;
      }

      return [];
    } catch (e) {
      print('Error fetching March historical weather data: $e');
      return [];
    }
  }

  // Get historical weather data for April
  static Future<List<HistoricalWeather>> getHistoricalData1() async {
    try {
      final DatabaseReference historyRef =
          _database.child('historical_weather_1');
      final DataSnapshot snapshot = await historyRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            snapshot.value as Map<dynamic, dynamic>;
        final List<HistoricalWeather> weatherList = data.entries
            .map((entry) => HistoricalWeather.fromMap(
                Map<String, dynamic>.from(entry.value as Map)))
            .toList();

        // Sort the data by date
        weatherList.sort((a, b) => a.date.compareTo(b.date));
        return weatherList;
      }

      return [];
    } catch (e) {
      print('Error fetching April historical weather data: $e');
      return [];
    }
  }

  // Save historical air quality data to Firebase
  static Future<void> saveHistoricalAirData(List<HistoricalAir> airData) async {
    try {
      final DatabaseReference airRef =
          _database.child('historical_air_quality');

      // Create a batch update
      final Map<String, dynamic> updates = {};

      for (final air in airData) {
        final String timeKey = air.dt;
        updates[timeKey] = {
          'dt': air.dt,
          'aqi': air.aqi,
          'pm10': air.pm10,
          'pm2_5': air.pm2_5,
          'o3': air.o3,
        };
      }

      // Save all the data at once
      await airRef.update(updates);
    } catch (e) {
      print('Error saving historical air quality data: $e');
      rethrow;
    }
  }

  // Get historical air quality data from Firebase
  static Future<List<HistoricalAir>> getHistoricalAirData() async {
    try {
      final DatabaseReference airRef =
          _database.child('historical_air_quality');
      final DataSnapshot snapshot = await airRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            snapshot.value as Map<dynamic, dynamic>;

        final List<HistoricalAir> airQualityList = data.entries
            .map((entry) => HistoricalAir(
                  dt: entry.key,
                  aqi: entry.value['aqi'],
                  pm10: entry.value['pm10'],
                  pm2_5: entry.value['pm2_5'],
                  o3: entry.value['o3'],
                ))
            .toList();

        // Sort the data by datetime
        airQualityList.sort((a, b) => a.dt.compareTo(b.dt));
        return airQualityList;
      }

      return [];
    } catch (e) {
      print('Error fetching historical air quality data: $e');
      return [];
    }
  }

  // Get today's air quality data from Firebase
  static Future<void> saveTodayAirData(List<HistoricalAir> airData) async {
    try {
      final DatabaseReference airRef = _database.child('today_air_quality');
      // Create a batch update
      final Map<String, dynamic> updates = {};

      for (final air in airData) {
        final String timeKey = air.dt;
        updates[timeKey] = {
          'dt': air.dt,
          'aqi': air.aqi,
          'pm10': air.pm10,
          'pm2_5': air.pm2_5,
          'o3': air.o3,
        };
      }
      // Save all the data at once
      await airRef.update(updates);
    } catch (e) {
      print('Error saving today air quality data: $e');
      rethrow;
    }
  }

  // Get today's air quality data from Firebase
  static Future<List<HistoricalAir>> getTodayAirData() async {
    try {
      final DatabaseReference airRef = _database.child('today_air_quality');
      final DataSnapshot snapshot = await airRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            snapshot.value as Map<dynamic, dynamic>;

        final List<HistoricalAir> airQualityList = data.entries
            .map((entry) => HistoricalAir(
                  dt: entry.key,
                  aqi: entry.value['aqi'],
                  pm10: entry.value['pm10'],
                  pm2_5: entry.value['pm2_5'],
                  o3: entry.value['o3'],
                ))
            .toList();

        // Sort the data by datetime
        airQualityList.sort((a, b) => a.dt.compareTo(b.dt));
        return airQualityList;
      }

      return [];
    } catch (e) {
      print('Error fetching today air quality data: $e');
      return [];
    }
  }

  static Future<void> saveTomorrowAirData(List<HistoricalAir> airData) async {
    try {
      final DatabaseReference airRef = _database.child('tomorrow_air_quality');
      // Create a batch update
      final Map<String, dynamic> updates = {};

      for (final air in airData) {
        final String timeKey = air.dt;
        updates[timeKey] = {
          'dt': air.dt,
          'aqi': air.aqi,
          'pm10': air.pm10,
          'pm2_5': air.pm2_5,
          'o3': air.o3,
        };
      }
      // Save all the data at once
      await airRef.update(updates);
    } catch (e) {
      print('Error saving today air quality data: $e');
      rethrow;
    }
  }

  // Get tomorrow's air quality data from Firebase
  static Future<List<HistoricalAir>> getTomorrowAirData() async {
    try {
      final DatabaseReference airRef = _database.child('tomorrow_air_quality');
      final DataSnapshot snapshot = await airRef.get();

      if (snapshot.exists && snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            snapshot.value as Map<dynamic, dynamic>;

        final List<HistoricalAir> airQualityList = data.entries
            .map((entry) => HistoricalAir.fromMap({
                  'dt': entry.key,
                  'aqi': entry.value['aqi'],
                  'pm10': entry.value['pm10'],
                  'pm2_5': entry.value['pm2_5'],
                  'o3': entry.value['o3'],
                }))
            .toList();

        // Sort the data by datetime
        airQualityList.sort((a, b) => a.dt.compareTo(b.dt));
        return airQualityList;
      }

      return [];
    } catch (e) {
      print('Error fetching tomorrow air quality data: $e');
      return [];
    }
  }
}
