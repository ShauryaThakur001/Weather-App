import 'package:flutter/material.dart';
import 'package:weatherrapp/Firebase/FireStore_Service.dart';
import 'package:weatherrapp/Models/weatherModel.dart';
import 'package:weatherrapp/Services/weather_Service.dart';

class Locationscreen extends StatefulWidget {
  const Locationscreen({super.key});

  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final WeatherService _weatherService = WeatherService(
    'f011cca49027075b4b1357f7431ff529',
  );

  final TextEditingController cityController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  /// ✅ ADDED
  List<String> filteredCities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: const Text(
          "Saved Locations",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),

      /// 🔁 STREAM FROM FIRESTORE
      body: StreamBuilder<List<String>>(
        stream: _firestoreService.getSavedCities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final cityList = snapshot.data ?? [];

          /// ✅ INITIALIZE FILTER ON FIRST LOAD
          if (searchController.text.isEmpty) {
            filteredCities = cityList;
          }

          if (cityList.isEmpty) {
            return Center(
              child: Text(
                "No Saved Cities",
                style: TextStyle(fontSize: 24, color: Colors.grey.shade600),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      filteredCities = cityList
                          .where(
                            (city) => city
                                .toLowerCase()
                                .contains(value.toLowerCase()),
                          )
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 25,
                    ),
                    hintText: "Search City",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// ✅ NO CITY FOUND AFTER SEARCH
                if (filteredCities.isEmpty)
                  Center(
                    child: Text(
                      "No city found",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCities.length,
                      itemBuilder: (context, index) {
                        final cityName = filteredCities[index];

                        return FutureBuilder<Weathermodel>(
                          future: _weatherService.getWeather(cityName),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (snapshot.hasError || !snapshot.hasData) {
                              return const SizedBox();
                            }

                            final weather = snapshot.data!;

                            return Dismissible(
                              key: ValueKey(weather.cityName),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.red,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                await _firestoreService.removeCity(
                                  weather.cityName,
                                );
                                return true;
                              },
                              child: LocationWidget(
                                city: weather.cityName,
                                weather: weather.mainCondition,
                                degree:
                                    weather.temperature.toStringAsFixed(0),
                                icon:
                                    _getWeatherIcon(weather.mainCondition),
                                color:
                                    _getWeatherColor(weather.mainCondition),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),

      /// ➕ ADD CITY
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: _showAddCityDialog,
      ),
    );
  }

  void _showAddCityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add City"),
        content: TextField(
          controller: cityController,
          decoration: const InputDecoration(hintText: "Enter city name"),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final city = cityController.text.trim();
              if (city.isEmpty) return;

              try {
                await _weatherService.getWeather(city);
                await _firestoreService.addCity(city);
                cityController.clear();
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("City not found")),
                );
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.grain;
      default:
        return Icons.cloud_queue;
    }
  }

  MaterialColor _getWeatherColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Colors.orange;
      case 'rain':
        return Colors.blue;
      case 'cloud':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}

class LocationWidget extends StatelessWidget {
  final String city;
  final String weather;
  final String degree;
  final IconData icon;
  final MaterialColor color;

  const LocationWidget({
    super.key,
    required this.city,
    required this.weather,
    required this.degree,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          title: Text(
            city,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            weather,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          trailing: Text(
            "$degree°C",
            style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
