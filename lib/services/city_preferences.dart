import 'package:shared_preferences/shared_preferences.dart';

class CityPreferences {
  static const String _keyCities = 'saved_cities';

  // Lấy danh sách các thành phố đã lưu
  static Future<List<String>> getSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyCities) ?? [];
  }

  // Lưu một thành phố vào danh sách
  static Future<void> saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    final cities = await getSavedCities();
    if (!cities.contains(city)) {
      cities.add(city);
      await prefs.setStringList(_keyCities, cities);
    }
  }

  // Xóa một thành phố khỏi danh sách
  static Future<void> removeCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    final cities = await getSavedCities();
    cities.remove(city);
    await prefs.setStringList(_keyCities, cities);
  }
}
