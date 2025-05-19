import 'package:dio/dio.dart';
import 'package:weather_app_tutorial/constants/getDtTime.dart';
import 'package:weather_app_tutorial/models/air_quality.dart';
import 'package:weather_app_tutorial/models/historical_air.dart';
import 'package:weather_app_tutorial/models/historical_weather.dart';
import '/constants/constants.dart';
import '/models/hourly_weather.dart';
import '/models/weather.dart';
import '/models/weekly_weather.dart';
import '/services/getlocator.dart';
import '/utils/logging.dart';

// @immutable
// class ApiHelper {
//   static const baseUrl = 'https://api.openweathermap.org/data/2.5';
//   static const weeklyWeatherUrl =
//       'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';

//   static double lat = 0.0;
//   static double lon = 0.0;
//   static final dio = Dio();

//   //! Get lat and lon
//   static Future<void> fetchLocation() async {
//     final location = await getLocation();
//     lat = location.latitude;
//     lon = location.longitude;
//     print('Latitude: $lat, Longitude: $lon');
//   }

//   //* Current Weather
//   static Future<Weather> getCurrentWeather() async {
//     await fetchLocation();
//     final url = _constructWeatherUrl();
//     final response = await _fetchData(url);
//     return Weather.fromJson(response);
//   }

//   //* Hourly Weather
//   static Future<HourlyWeather> getHourlyForecast() async {
//     await fetchLocation();
//     final url = _constructForecastUrl();
//     final response = await _fetchData(url);
//     return HourlyWeather.fromJson(response);
//   }

//   //* Weekly weather
//   static Future<WeeklyWeather> getWeeklyForecast() async {
//     await fetchLocation();
//     final url = _constructWeeklyForecastUrl();
//     final response = await _fetchData(url);
//     return WeeklyWeather.fromJson(response);
//   }

//   //* Weather by City Name
//   static Future<Weather> getWeatherByCityName({
//     required String cityName,
//   }) async {
//     final url = _constructWeatherByCityUrl(cityName);
//     final response = await _fetchData(url);
//     return Weather.fromJson(response);
//   }

//   //! Build urls
//   static String _constructWeatherUrl() =>
//       '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

//   static String _constructForecastUrl() =>
//       '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

//   static String _constructWeatherByCityUrl(String cityName) =>
//       '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

//   static String _constructWeeklyForecastUrl() =>
//       '$weeklyWeatherUrl&latitude=$lat&longitude=$lon';

//   //* Fetch Data for a url
//   static Future<Map<String, dynamic>> _fetchData(String url) async {
//     try {
//       final response = await dio.get(url);

//       if (response.statusCode == 200) {
//         return response.data;
//       } else {
//         printWarning('Failed to load data: ${response.statusCode}');
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       printWarning('Error fetching data from $url: $e');
//       throw Exception('Error fetching data');
//     }
//   }
// }
class ApiHelper {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const weeklyWeatherUrl =
      'https://api.open-meteo.com/v1/forecast?current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';
  static const airQualityUrl =
      'https://api.openweathermap.org/data/2.5/air_pollution';
  static const historyWeatherUrl =
      'https://archive-api.open-meteo.com/v1/archive?daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=auto';
  static const historicalAirUrl =
      'https://api.openweathermap.org/data/2.5/air_pollution/history';
  static double lat = 0.0;
  static double lon = 0.0;
  static final dio = Dio();
// Getlat and lon

  static Future<void> fetchLocation() async {
    final location = await getLocation();
    lat = location.latitude;
    lon = location.longitude;
    print('Latitude: $lat, Longitude: $lon');
  }

  // Current Weather
  static Future<Weather> getCurrentWeather() async {
    await fetchLocation();
    final url = _constructWeatherUrl();
    final reponse = await _fetchData(url);
    return Weather.fromJson(reponse);
  }

  // Hourly Weather
  static Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation();
    final url = _constructForecastUrl();
    final reponse = await _fetchData(url);
    return HourlyWeather.fromJson(reponse);
  }

  // Weekly Weather
  static Future<WeeklyWeather> getWeeklyForecast() async {
    await fetchLocation();
    final url = _constructWeeklyForecastUrl();
    final reponse = await _fetchData(url);
    return WeeklyWeather.fromJson(reponse);
  }

  // Weather by City Name
  static Future<Weather> getWeatherByCityName({
    required String cityName,
  }) async {
    final url = _constructWeatherByCityUrl(cityName);
    final reponse = await _fetchData(url);
    return Weather.fromJson(reponse);
  }

  // Air Quality
  static Future<AirQualityModel> getAirQuality() async {
    await fetchLocation();
    final url = _constructAirQualityUrl();
    final response = await _fetchData(url);
    return AirQualityModel.fromJson(response);
  }

  // Historical Weather Data
  static Future<List<HistoricalWeather>> getHistoricalWeatherDataApi1() async {
    await fetchLocation();

    // Calculate date range for the past month
    final DateTime now = DateTime.now();
    final DateTime endDate = DateTime(now.year, now.month - 1, 30);
    final DateTime startDate = DateTime(now.year, now.month - 1, 1);

    final String formattedStartDate =
        startDate.toIso8601String().substring(0, 10);
    final String formattedEndDate = endDate.toIso8601String().substring(0, 10);

    final url =
        _constructHistoricalWeatherUrl(formattedStartDate, formattedEndDate);
    final response = await _fetchData(url);

    final List<HistoricalWeather> historicalData = [];

    if (response.containsKey('daily') &&
        response['daily'].containsKey('time') &&
        response['daily'].containsKey('temperature_2m_max') &&
        response['daily'].containsKey('temperature_2m_min') &&
        response['daily'].containsKey('precipitation_sum')) {
      final List<String> times = List<String>.from(response['daily']['time']);
      final List<double> maxTemps =
          List<double>.from(response['daily']['temperature_2m_max']);
      final List<double> minTemps =
          List<double>.from(response['daily']['temperature_2m_min']);
      final List<double> precipitations =
          List<double>.from(response['daily']['precipitation_sum']);

      for (int i = 0; i < times.length; i++) {
        historicalData.add(HistoricalWeather(
          date: DateTime.parse(times[i]),
          maxTemp: maxTemps[i],
          minTemp: minTemps[i],
          avgTemp: (maxTemps[i] + minTemps[i]) / 2,
          precipitation: precipitations[i],
        ));
      }
    }

    return historicalData;
  }

  // Historical Weather Data
  static Future<List<HistoricalWeather>> getHistoricalWeatherDataApi2() async {
    await fetchLocation();

    // Calculate date range for the past month
    final DateTime now = DateTime.now();
    final DateTime endDate = DateTime(now.year, now.month - 2, 30);
    final DateTime startDate = DateTime(now.year, now.month - 2, 1);

    final String formattedStartDate =
        startDate.toIso8601String().substring(0, 10);
    final String formattedEndDate = endDate.toIso8601String().substring(0, 10);

    final url =
        _constructHistoricalWeatherUrl(formattedStartDate, formattedEndDate);
    final response = await _fetchData(url);

    final List<HistoricalWeather> historicalData = [];

    if (response.containsKey('daily') &&
        response['daily'].containsKey('time') &&
        response['daily'].containsKey('temperature_2m_max') &&
        response['daily'].containsKey('temperature_2m_min') &&
        response['daily'].containsKey('precipitation_sum')) {
      final List<String> times = List<String>.from(response['daily']['time']);
      final List<double> maxTemps =
          List<double>.from(response['daily']['temperature_2m_max']);
      final List<double> minTemps =
          List<double>.from(response['daily']['temperature_2m_min']);
      final List<double> precipitations =
          List<double>.from(response['daily']['precipitation_sum']);

      for (int i = 0; i < times.length; i++) {
        historicalData.add(HistoricalWeather(
          date: DateTime.parse(times[i]),
          maxTemp: maxTemps[i],
          minTemp: minTemps[i],
          avgTemp: (maxTemps[i] + minTemps[i]) / 2,
          precipitation: precipitations[i],
        ));
      }
    }

    return historicalData;
  }

  // Get Current Month Historical Data (up to yesterday)
  static Future<List<HistoricalWeather>> getCurrentMonthHistoricalData() async {
    await fetchLocation();

    // Calculate date range from the 1st of current month to yesterday
    final DateTime now = DateTime.now();
    final DateTime startDate = DateTime(now.year, now.month, 1);
    final DateTime endDate = now.subtract(const Duration(days: 2));

    final String formattedStartDate =
        startDate.toIso8601String().substring(0, 10);
    final String formattedEndDate = endDate.toIso8601String().substring(0, 10);

    final url =
        _constructHistoricalWeatherUrl(formattedStartDate, formattedEndDate);
    final response = await _fetchData(url);

    final List<HistoricalWeather> historicalData = [];

    if (response.containsKey('daily') &&
        response['daily'].containsKey('time') &&
        response['daily'].containsKey('temperature_2m_max') &&
        response['daily'].containsKey('temperature_2m_min') &&
        response['daily'].containsKey('precipitation_sum')) {
      final List<String> times = List<String>.from(response['daily']['time']);
      final List<double> maxTemps =
          List<double>.from(response['daily']['temperature_2m_max']);
      final List<double> minTemps =
          List<double>.from(response['daily']['temperature_2m_min']);
      final List<double> precipitations =
          List<double>.from(response['daily']['precipitation_sum']);

      for (int i = 0; i < times.length; i++) {
        historicalData.add(HistoricalWeather(
          date: DateTime.parse(times[i]),
          maxTemp: maxTemps[i],
          minTemp: minTemps[i],
          avgTemp: (maxTemps[i] + minTemps[i]) / 2,
          precipitation: precipitations[i],
        ));
      }
    }

    return historicalData;
  }

  static Future<List<HistoricalAir>> getHistoricalAirData() async {
    await fetchLocation();
    final DateTime now = DateTime.now();
    final DateTime Date = DateTime(now.year, now.month, now.day - 1);

    final List timeDT = getDtTimeVN(Date);
    final String startDate = timeDT[0].toString();
    final String endDate = timeDT[1].toString();
    print("Từ dt = $startDate đến dt = $endDate");
    final url = _constructHistoricalAirUrl(startDate, endDate);
    final response = await _fetchData(url);
    final List<HistoricalAir> historicalData = [];
    if (response.containsKey('list') && response['list'].isNotEmpty) {
      final List<dynamic> list = response['list'];
      for (var item in list) {
        historicalData.add(HistoricalAir(
          dt: item['dt'].toString(),
          aqi: item['main']['aqi'],
          pm10: item['components']['pm10'].toDouble(),
          pm2_5: item['components']['pm2_5'].toDouble(),
          o3: item['components']['o3'].toDouble(),
        ));
      }
    }
    return historicalData;
  }

  static Future<List<HistoricalAir>> getTodayAirData() async {
    await fetchLocation();
    final DateTime now = DateTime.now();
    final DateTime Date = DateTime(now.year, now.month, now.day);

    final List timeDT = getDtTimeVN(Date);
    final String startDate = timeDT[0].toString();
    final String endDate = timeDT[1].toString();
    print("Từ dt = $startDate đến dt = $endDate");
    final url = _constructHistoricalAirUrl(startDate, endDate);
    final response = await _fetchData(url);
    final List<HistoricalAir> historicalData = [];
    if (response.containsKey('list') && response['list'].isNotEmpty) {
      final List<dynamic> list = response['list'];
      for (var item in list) {
        historicalData.add(HistoricalAir(
          dt: item['dt'].toString(),
          aqi: item['main']['aqi'],
          pm10: item['components']['pm10'].toDouble(),
          pm2_5: item['components']['pm2_5'].toDouble(),
          o3: item['components']['o3'].toDouble(),
        ));
      }
    }
    return historicalData;
  }

  static Future<List<HistoricalAir>> getTomorrowAirData() async {
    await fetchLocation();
    final DateTime now = DateTime.now();
    final DateTime Date = DateTime(now.year, now.month, now.day + 1);

    final List timeDT = getDtTimeVN(Date);
    final String startDate = timeDT[0].toString();
    final String endDate = timeDT[1].toString();
    print("Từ dt = $startDate đến dt = $endDate");
    final url = _constructHistoricalAirUrl(startDate, endDate);
    final response = await _fetchData(url);
    final List<HistoricalAir> historicalData = [];
    if (response.containsKey('list') && response['list'].isNotEmpty) {
      final List<dynamic> list = response['list'];
      for (var item in list) {
        historicalData.add(HistoricalAir(
          dt: item['dt'].toString(),
          aqi: item['main']['aqi'],
          pm10: item['components']['pm10'].toDouble(),
          pm2_5: item['components']['pm2_5'].toDouble(),
          o3: item['components']['o3'].toDouble(),
        ));
      }
    }
    return historicalData;
  }

  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructForecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants.apiKey}';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  static String _constructWeeklyForecastUrl() =>
      '$weeklyWeatherUrl&latitude=$lat&longitude=$lon';

  static String _constructAirQualityUrl() =>
      '$airQualityUrl?lat=$lat&lon=$lon&appid=${Constants.apiKey}';

  static String _constructHistoricalWeatherUrl(
          String startDate, String endDate) =>
      '$historyWeatherUrl&latitude=$lat&longitude=$lon&start_date=$startDate&end_date=$endDate';
  static String _constructHistoricalAirUrl(String startDate, String endDate) =>
      '$historicalAirUrl?lat=$lat&lon=$lon&start=$startDate&end=$endDate&appid=${Constants.apiKey}';

  static Future<Map<String, dynamic>> _fetchData(String url) async {
    try {
      final reponse = await dio.get(url);
      if (reponse.statusCode == 200) {
        return reponse.data;
      } else {
        printWarning('Failed to load data: ${reponse.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      printWarning('Error fetching data from $url: $e');
      throw Exception('Error fetching data');
    }
  }
}
