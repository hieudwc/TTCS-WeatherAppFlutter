import 'package:flutter/foundation.dart';

class HistoricalAir {
  final String dt;
  final int aqi;
  final double pm10;
  final double pm2_5;
  final double o3;

  HistoricalAir({
    required this.dt,
    required this.aqi,
    required this.pm10,
    required this.pm2_5,
    required this.o3,
  });

  // Convert model to map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'aqi': aqi,
      'pm10': pm10,
      'pm2_5': pm2_5,
      'o3': o3,
    };
  }

  // Create model from map (from Firebase)
  factory HistoricalAir.fromMap(Map<String, dynamic> map) {
    return HistoricalAir(
      dt: map['dt']?.toString() ?? '',
      aqi: map['aqi']?.toInt() ?? 0,
      pm10: _toDouble(map['pm10']),
      pm2_5: _toDouble(map['pm2_5']),
      o3: _toDouble(map['o3']),
    );
  }

  // Helper method to convert various number types to double
  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
