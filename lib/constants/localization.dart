import 'package:weather_app_tutorial/providers/language_provider.dart';

class Localization {
  final AppLanguage language;

  Localization({required this.language});
  static final Map<String, Map<AppLanguage, String>> _localizedValues = {
    'title': {
      AppLanguage.en: 'Weather',
      AppLanguage.vn: 'Thời tiết',
    },
    'overcast clouds': {
      AppLanguage.en: 'Overcast clouds',
      AppLanguage.vn: 'Mây u ám',
    },
    'Ha Dong': {
      AppLanguage.en: 'Ha Dong',
      AppLanguage.vn: 'Hà Đông',
    },
    'Hanoi': {
      AppLanguage.en: 'Hanoi',
      AppLanguage.vn: 'Hà Nội',
    },
    'Bac Ninh': {
      AppLanguage.en: 'Bac Ninh',
      AppLanguage.vn: 'Bắc Ninh',
    },
    'Hoa Binh': {
      AppLanguage.en: 'Hoa Binh',
      AppLanguage.vn: 'Hòa Bình',
    },
    'Thai Binh': {
      AppLanguage.en: 'Thai Binh',
      AppLanguage.vn: 'Thái Bình',
    },
    'Temperature': {
      AppLanguage.en: 'Temperature',
      AppLanguage.vn: 'Nhiệt độ',
    },
    'Wind': {
      AppLanguage.en: 'Wind',
      AppLanguage.vn: 'Gió',
    },
    'Humidity': {
      AppLanguage.en: 'Humidity',
      AppLanguage.vn: 'Độ ẩm',
    },
    'Today': {
      AppLanguage.en: 'Today',
      AppLanguage.vn: 'Hôm nay',
    },
    'View full report': {
      AppLanguage.en: 'View full report',
      AppLanguage.vn: 'Xem đầy đủ',
    },
    'See Details': {
      AppLanguage.en: 'See Details',
      AppLanguage.vn: 'Xem chi tiết',
    },
    'Favourite City': {
      AppLanguage.en: 'Favourite City',
      AppLanguage.vn: 'Thành phố yêu thích',
    },
    'Notification': {
      AppLanguage.en: 'Notification',
      AppLanguage.vn: 'Thông báo',
    },
    'Search': {
      AppLanguage.en: 'Search',
      AppLanguage.vn: 'Tìm kiếm',
    },
    'Enter the city name to view weather information': {
      AppLanguage.en: 'Enter the city name to view weather information',
      AppLanguage.vn: 'Nhập tên thành phố để xem thông tin thời tiết',
    },
    'Forecast Report': {
      AppLanguage.en: 'Forecast Report',
      AppLanguage.vn: 'Báo cáo dự báo',
    },
    'Next Forecast': {
      AppLanguage.en: 'Next Forecast',
      AppLanguage.vn: 'Dự báo tiếp theo',
    },
    'Switch to English': {
      AppLanguage.en: 'Switch to English',
      AppLanguage.vn: 'Chuyển sang Tiếng Anh',
    },
    'Monday': {
      AppLanguage.en: 'Monday',
      AppLanguage.vn: 'Thứ hai',
    },
    'Tuesday': {
      AppLanguage.en: 'Tuesday',
      AppLanguage.vn: 'Thứ ba',
    },
    'Wednesday': {
      AppLanguage.en: 'Wednesday',
      AppLanguage.vn: 'Thứ tư',
    },
    'Thursday': {
      AppLanguage.en: 'Thursday',
      AppLanguage.vn: 'Thứ năm',
    },
    'Friday': {
      AppLanguage.en: 'Friday',
      AppLanguage.vn: 'Thứ sáu',
    },
    'Saturday': {
      AppLanguage.en: 'Saturday',
      AppLanguage.vn: 'Thứ bảy',
    },
    'Sunday': {
      AppLanguage.en: 'Sunday',
      AppLanguage.vn: 'Chủ nhật',
    },
    'Settings': {
      AppLanguage.en: 'Settings',
      AppLanguage.vn: 'Cài đặt',
    },
    'Language': {
      AppLanguage.en: 'Language',
      AppLanguage.vn: 'Ngôn ngữ',
    },
    'Day Mode': {
      AppLanguage.en: 'Day Mode',
      AppLanguage.vn: 'Chế độ Ngày',
    },
    'Night Mode': {
      AppLanguage.en: 'Night Mode',
      AppLanguage.vn: 'Chế độ Đêm',
    },
    'clear sky': {
      AppLanguage.en: 'Clear sky',
      AppLanguage.vn: 'Trời quang đãng',
    },
    'few clouds': {
      AppLanguage.en: 'Few clouds',
      AppLanguage.vn: 'Ít mây',
    },
    'scattered clouds': {
      AppLanguage.en: 'Scattered clouds',
      AppLanguage.vn: 'Mây rải rác',
    },
    'broken clouds': {
      AppLanguage.en: 'Broken clouds',
      AppLanguage.vn: 'Mây đứt đoạn',
    },
    'shower rain': {
      AppLanguage.en: 'Shower rain',
      AppLanguage.vn: 'Mưa rào',
    },
    'rain': {
      AppLanguage.en: 'Rain',
      AppLanguage.vn: 'Mưa',
    },
    'light rain': {
      AppLanguage.en: 'Light rain',
      AppLanguage.vn: 'Mưa nhẹ',
    },
    'moderate rain': {
      AppLanguage.en: 'Moderate rain',
      AppLanguage.vn: 'Mưa vừa',
    },
    'heavy intensity rain': {
      AppLanguage.en: 'Heavy intensity rain',
      AppLanguage.vn: 'Mưa to',
    },
    'very heavy rain': {
      AppLanguage.en: 'Very heavy rain',
      AppLanguage.vn: 'Mưa rất to',
    },
    'extreme rain': {
      AppLanguage.en: 'Extreme rain',
      AppLanguage.vn: 'Mưa cực to',
    },
    'freezing rain': {
      AppLanguage.en: 'Freezing rain',
      AppLanguage.vn: 'Mưa băng giá',
    },
    'thunderstorm': {
      AppLanguage.en: 'Thunderstorm',
      AppLanguage.vn: 'Giông bão',
    },
    'thunderstorm with light rain': {
      AppLanguage.en: 'Thunderstorm with light rain',
      AppLanguage.vn: 'Giông bão với mưa nhẹ',
    },
    'thunderstorm with rain': {
      AppLanguage.en: 'Thunderstorm with rain',
      AppLanguage.vn: 'Giông bão với mưa',
    },
    'thunderstorm with heavy rain': {
      AppLanguage.en: 'Thunderstorm with heavy rain',
      AppLanguage.vn: 'Giông bão với mưa to',
    },
    'snow': {
      AppLanguage.en: 'Snow',
      AppLanguage.vn: 'Tuyết',
    },
    'light snow': {
      AppLanguage.en: 'Light snow',
      AppLanguage.vn: 'Tuyết nhẹ',
    },
    'heavy snow': {
      AppLanguage.en: 'Heavy snow',
      AppLanguage.vn: 'Tuyết dày',
    },
    'sleet': {
      AppLanguage.en: 'Sleet',
      AppLanguage.vn: 'Mưa tuyết',
    },
    'mist': {
      AppLanguage.en: 'Mist',
      AppLanguage.vn: 'Sương mù nhẹ',
    },
    'fog': {
      AppLanguage.en: 'Fog',
      AppLanguage.vn: 'Sương mù',
    },
    'haze': {
      AppLanguage.en: 'Haze',
      AppLanguage.vn: 'Sương mờ',
    },
    'smoke': {
      AppLanguage.en: 'Smoke',
      AppLanguage.vn: 'Khói',
    },
    'dust': {
      AppLanguage.en: 'Dust',
      AppLanguage.vn: 'Bụi',
    },
    'sand': {
      AppLanguage.en: 'Sand',
      AppLanguage.vn: 'Cát',
    },
    'volcanic ash': {
      AppLanguage.en: 'Volcanic ash',
      AppLanguage.vn: 'Tro núi lửa',
    },
    'squalls': {
      AppLanguage.en: 'Squalls',
      AppLanguage.vn: 'Gió giật',
    },
    'tornado': {
      AppLanguage.en: 'Tornado',
      AppLanguage.vn: 'Lốc xoáy',
    },
    'Visibility': {
      AppLanguage.en: 'Visibility',
      AppLanguage.vn: 'Tầm nhìn',
    },
    'Pressure': {
      AppLanguage.en: 'Pressure',
      AppLanguage.vn: 'Áp suất',
    },
    'Please enter city name': {
      AppLanguage.en: 'Please enter city name',
      AppLanguage.vn: 'Vui lòng nhập tên thành phố',
    },
    'City not found. Please try again.': {
      AppLanguage.en: 'City not found. Please try again.',
      AppLanguage.vn: 'Không tìm thấy thành phố. Vui lòng thử lại.',
    },
    'Searching for your location weather...': {
      AppLanguage.en: 'Searching for your location weather...',
      AppLanguage.vn: 'Đang tìm thời tiết ở vị trí của bạn...',
    },
    'Error': {
      AppLanguage.en: 'Error',
      AppLanguage.vn: 'Lỗi',
    },
    'Air Quality': {
      AppLanguage.en: 'Air Quality',
      AppLanguage.vn: 'Chất lượng không khí',
    },
    'Air Quality Index': {
      AppLanguage.en: 'Air Quality Index',
      AppLanguage.vn: 'Chỉ số chất lượng không khí',
    },
    'Pollutants': {
      AppLanguage.en: 'Pollutants',
      AppLanguage.vn: 'Chất ô nhiễm',
    },
    'Good': {
      AppLanguage.en: 'Good',
      AppLanguage.vn: 'Tốt',
    },
    'Fair': {
      AppLanguage.en: 'Fair',
      AppLanguage.vn: 'Khá',
    },
    'Moderate': {
      AppLanguage.en: 'Moderate',
      AppLanguage.vn: 'Trung bình',
    },
    'Poor': {
      AppLanguage.en: 'Poor',
      AppLanguage.vn: 'Kém',
    },
    'Very Poor': {
      AppLanguage.en: 'Very Poor',
      AppLanguage.vn: 'Rất kém',
    },
    'Could not load air quality data': {
      AppLanguage.en: 'Could not load air quality data',
      AppLanguage.vn: 'Không thể tải dữ liệu chất lượng không khí',
    },
    // ignore: equal_keys_in_map
    'Air Quality': {
      AppLanguage.en: 'Air Quality',
      AppLanguage.vn: 'Chất lượng không khí',
    },
    'Weather Notification': {
      AppLanguage.en: 'Weather Notification',
      AppLanguage.vn: 'Thông báo thời tiết',
    },
    'Air quality is good': {
      AppLanguage.en: 'Air quality is good',
      AppLanguage.vn: 'Chất lượng không khí tốt',
    },
    'Air quality is acceptable': {
      AppLanguage.en: 'Air quality is acceptable',
      AppLanguage.vn: 'Chất lượng không khí chấp nhận được',
    },
    'Sensitive groups may experience effects': {
      AppLanguage.en: 'Sensitive groups may experience effects',
      AppLanguage.vn: 'Những nhóm nhạy cảm có thể bị ảnh hưởng',
    },
    'Everyone may experience health effects': {
      AppLanguage.en: 'Everyone may experience health effects',
      AppLanguage.vn: 'Mọi người có thể bị ảnh hưởng đến sức khỏe',
    },
    'Health alert: everyone may be affected': {
      AppLanguage.en: 'Health alert: everyone may be affected',
      AppLanguage.vn: 'Cảnh báo sức khỏe: mọi người có thể bị ảnh hưởng',
    },
    'No data available': {
      AppLanguage.en: 'No data available',
      AppLanguage.vn: 'Không có dữ liệu',
    },
    'Pollutans': {
      AppLanguage.en: 'Pollutants',
      AppLanguage.vn: 'Chất ô nhiễm',
    },
    'AQI Levels': {
      AppLanguage.en: 'AQI Levels',
      AppLanguage.vn: 'Cấp độ AQI',
    },
    // ignore: equal_keys_in_map
    'Good': {
      AppLanguage.en: 'Good',
      AppLanguage.vn: 'Tốt',
    },
    // ignore: equal_keys_in_map
    'Fair': {
      AppLanguage.en: 'Fair',
      AppLanguage.vn: 'Khá',
    },
    // ignore: equal_keys_in_map
    'Moderate': {
      AppLanguage.en: 'Moderate',
      AppLanguage.vn: 'Trung bình',
    },
    // ignore: equal_keys_in_map
    'Poor': {
      AppLanguage.en: 'Poor',
      AppLanguage.vn: 'Kém',
    },
    // ignore: equal_keys_in_map
    'Very Poor': {
      AppLanguage.en: 'Very Poor',
      AppLanguage.vn: 'Rất kém',
    },
    'Weather Statistics': {
      AppLanguage.en: 'Weather Statistics',
      AppLanguage.vn: 'Thống kê thời tiết',
    },
    'View detailed weather statistics and historical data': {
      AppLanguage.en: 'View detailed weather statistics and historical data',
      AppLanguage.vn: 'Xem chi tiết thống kê và dữ liệu trong quá khứ'
    },
    'Historical Temperature': {
      AppLanguage.en: 'Historical Temperature',
      AppLanguage.vn: 'Lịch sử thời tiết'
    },
    'View temperature data for month in the past': {
      AppLanguage.en: 'View temperature data for month in the past',
      AppLanguage.vn: 'Xem dữ liệu thời tiết từng tháng trong quá khứ'
    },
    'March': {AppLanguage.en: 'March', AppLanguage.vn: 'Tháng 3'},
    'April': {AppLanguage.en: 'April', AppLanguage.vn: 'Tháng 4'},
    'May': {AppLanguage.en: 'May', AppLanguage.vn: 'Tháng 5'},
    'June': {AppLanguage.en: 'June', AppLanguage.vn: 'Tháng 6'},
    'July': {AppLanguage.en: 'July', AppLanguage.vn: 'Tháng 7'},
    'August': {AppLanguage.en: 'August', AppLanguage.vn: 'Tháng 8'},
    'September': {AppLanguage.en: 'September', AppLanguage.vn: 'Tháng 9'},
    'October': {AppLanguage.en: 'October', AppLanguage.vn: 'Tháng 10'},
    'November': {AppLanguage.en: 'November', AppLanguage.vn: 'Tháng 11'},
    'December': {AppLanguage.en: 'December', AppLanguage.vn: 'Tháng 12'},
    'January': {AppLanguage.en: 'January', AppLanguage.vn: 'Tháng 1'},
    'February': {AppLanguage.en: 'February', AppLanguage.vn: 'Tháng 2'},
    'Present': {AppLanguage.en: 'Present', AppLanguage.vn: 'Hiện tại'},
    'Historical Weather': {
      AppLanguage.en: 'Historical Weather',
      AppLanguage.vn: 'Lịch sử thời tiết'
    },
    'Loading weather data...': {
      AppLanguage.en: 'Loading weather data...',
      AppLanguage.vn: 'Đang tải dữ liệu thời tiết...'
    },
    'No data available for': {
      AppLanguage.en: 'No data available for',
      AppLanguage.vn: 'Không có dữ liệu cho'
    },
    'TEMPERATURE CHART': {
      AppLanguage.en: 'TEMPERATURE CHART',
      AppLanguage.vn: 'BIỂU ĐỒ NHIỆT ĐỘ'
    },
    'Daily temperature data for': {
      AppLanguage.en: 'Daily temperature data for',
      AppLanguage.vn: 'Dữ liệu nhiệt độ hàng ngày cho'
    },
    'Refresh Data': {
      AppLanguage.en: 'Refresh Data',
      AppLanguage.vn: 'Làm mới dữ liệu'
    },
    'Try Again': {AppLanguage.en: 'Try Again', AppLanguage.vn: 'Thử lại'}
  };
  String translate(String key, AppLanguage language) {
    return _localizedValues[key]?[language] ?? key;
  }
}
