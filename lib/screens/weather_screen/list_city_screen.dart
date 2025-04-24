import 'package:flutter/material.dart';
import 'package:weather_app_tutorial/screens/weather_detail_screen.dart';
import 'package:weather_app_tutorial/services/city_preferences.dart';

class SavedCitiesScreen extends StatefulWidget {
  const SavedCitiesScreen({super.key});

  @override
  State<SavedCitiesScreen> createState() => _SavedCitiesScreenState();
}

class _SavedCitiesScreenState extends State<SavedCitiesScreen> {
  List<String> savedCities = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCities();
  }

  Future<void> _loadSavedCities() async {
    final cities = await CityPreferences.getSavedCities();
    setState(() {
      savedCities = cities;
    });
  }

  Future<void> _removeCity(String city) async {
    await CityPreferences.removeCity(city);
    _loadSavedCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách thành phố yêu thích'),
        backgroundColor: Colors.blueAccent,
      ),
      body: savedCities.isEmpty
          ? const Center(
              child: Text(
                'Không có thành phố nào trong danh sách yêu thích.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: savedCities.length,
              itemBuilder: (context, index) {
                final city = savedCities[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    title: Text(
                      city,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: const Icon(
                      Icons.location_city,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeCity(city),
                    ),
                    onTap: () {
                      // Chuyển đến trang chi tiết của thành phố
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherDetailScreen(
                            cityName: city,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
