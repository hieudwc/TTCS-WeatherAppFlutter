class AirQualityModel {
  final List<AirQualityData> list;
  final Coord coord;

  AirQualityModel({
    required this.list,
    required this.coord,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    return AirQualityModel(
      list: (json['list'] as List<dynamic>)
          .map((e) => AirQualityData.fromJson(e as Map<String, dynamic>))
          .toList(),
      coord: Coord.fromJson(json['coord'] as Map<String, dynamic>),
    );
  }
}

class AirQualityData {
  final Main main;
  final Components components;
  final int dt;

  AirQualityData({
    required this.main,
    required this.components,
    required this.dt,
  });

  factory AirQualityData.fromJson(Map<String, dynamic> json) {
    return AirQualityData(
      main: Main.fromJson(json['main'] as Map<String, dynamic>),
      components:
          Components.fromJson(json['components'] as Map<String, dynamic>),
      dt: json['dt'] as int,
    );
  }
}

class Main {
  final int aqi;

  Main({
    required this.aqi,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      aqi: json['aqi'] as int,
    );
  }

  // Hàm để lấy mô tả về chất lượng không khí dựa vào chỉ số AQI
  String getAqiDescription() {
    switch (aqi) {
      case 1:
        return 'Good';
      case 2:
        return 'Fair';
      case 3:
        return 'Moderate';
      case 4:
        return 'Poor';
      case 5:
        return 'Very Poor';
      default:
        return 'Unknown';
    }
  }

  // Hàm để lấy màu tương ứng với chỉ số AQI
  String getAqiColor() {
    switch (aqi) {
      case 1:
        return '#00FF00'; // Xanh lá - Good
      case 2:
        return '#FFFF00'; // Vàng - Fair
      case 3:
        return '#FF9900'; // Cam - Moderate
      case 4:
        return '#FF0000'; // Đỏ - Poor
      case 5:
        return '#990066'; // Tím - Very Poor
      default:
        return '#CCCCCC'; // Xám - Unknown
    }
  }
}

class Components {
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm2_5;
  final double pm10;
  final double nh3;

  Components({
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
  });

  factory Components.fromJson(Map<String, dynamic> json) {
    return Components(
      co: (json['co'] as num).toDouble(),
      no: (json['no'] as num).toDouble(),
      no2: (json['no2'] as num).toDouble(),
      o3: (json['o3'] as num).toDouble(),
      so2: (json['so2'] as num).toDouble(),
      pm2_5: (json['pm2_5'] as num).toDouble(),
      pm10: (json['pm10'] as num).toDouble(),
      nh3: (json['nh3'] as num).toDouble(),
    );
  }
}

class Coord {
  final double lon;
  final double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: (json['lon'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );
  }
}
