// class HistoricalWeather {
//   final DateTime date;
//   final double maxTemp;
//   final double minTemp;
//   final double precipitation;

//   HistoricalWeather({
//     required this.date,
//     required this.maxTemp,
//     required this.minTemp,
//     required this.precipitation,
//   });

//   // Convert model to map for Firebase
//   Map<String, dynamic> toMap() {
//     return {
//       'date': date.toIso8601String(),
//       'maxTemp': maxTemp,
//       'minTemp': minTemp,
//       'precipitation': precipitation,
//     };
//   }

//   // Create model from map (from Firebase)
//   factory HistoricalWeather.fromMap(Map<String, dynamic> map) {
//     return HistoricalWeather(
//       date: DateTime.parse(map['date']),
//       maxTemp: map['maxTemp']?.toDouble() ?? 0.0,
//       minTemp: map['minTemp']?.toDouble() ?? 0.0,
//       precipitation: map['precipitation']?.toDouble() ?? 0.0,
//     );
//   }
// }

class HistoricalWeather {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final double avgTemp;
  final double precipitation;

  HistoricalWeather({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.avgTemp,
    required this.precipitation,
  });

  //Convert model to map for firebase
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'maxTemp': maxTemp,
      'minTemp': minTemp,
      'avgTemp': avgTemp,
      'precipitation': precipitation
    };
  }

  //Create a model from firebase
  factory HistoricalWeather.fromMap(Map<String, dynamic> map) {
    return HistoricalWeather(
      date: DateTime.parse(map['date']),
      maxTemp: map['maxTemp']?.toDouble() ?? 0.0,
      minTemp: map['minTemp']?.toDouble() ?? 0.0,
      avgTemp: map['avgTemp']?.toDouble() ?? 0.0,
      precipitation: map['precipitation']?.toDouble() ?? 0.0,
    );
  }
}
