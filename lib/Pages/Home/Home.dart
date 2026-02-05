import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherrapp/Models/weatherModel.dart';
import 'package:weatherrapp/Services/weather_Service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService =
      WeatherService('f011cca49027075b4b1357f7431ff529');

  Weathermodel? _weatherModel;

  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  // ---------------- Fetch Weather ----------------
  Future<void> _fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      final weather = await _weatherService.getWeather(cityName);

      setState(() {
        _weatherModel = weather;
        isLoading = false;
        errorMessage = "";
      });
    } catch (e) {
      debugPrint("Weather fetch error: $e");

      setState(() {
        isLoading = false;
        _weatherModel = null;
        errorMessage = "Unable to fetch weather data";
      });
    }
  }

  // ---------------- Weather Animation ----------------
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return "assets/animations/sunny.json";
    }

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return "assets/animations/windy.json";

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return "assets/animations/windy.json";

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return "assets/animations/rainy.json";

      case 'snow':
        return "assets/animations/snow.json";

      case 'thunderstorm':
        return "assets/animations/rainy.json";

      case 'clear':
        return "assets/animations/sunny.json";

      default:
        return "assets/animations/sunny.json";
    }
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Weather"),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()

            // ❌ Error UI
            : _weatherModel == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off,
                          size: 60, color: Colors.grey),
                      const SizedBox(height: 12),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          _fetchWeather();
                        },
                        child: const Text("Retry"),
                      )
                    ],
                  )

                // ✅ Weather UI
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _weatherModel!.cityName,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${_weatherModel!.temperature.toStringAsFixed(0)} °C",
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 12),
                      Lottie.asset(
                        getWeatherAnimation(
                          _weatherModel!.mainCondition,
                        ),
                        height: 160,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _weatherModel!.mainCondition,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
