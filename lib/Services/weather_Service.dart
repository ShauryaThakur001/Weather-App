import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherrapp/Models/weatherModel.dart';
import 'package:http/http.dart'as http;

class WeatherService {
  static const BASE_URl = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weathermodel>getWeather(String cityName)async{
    final response = await http.get(Uri.parse('$BASE_URl?q=$cityName&appid=$apiKey&units=metric'));

    if(response.statusCode==200){
      final result=Weathermodel.fromJson(jsonDecode(response.body));
      print("Error $result");
      return result;
    }
    else{
      throw Exception("Failed to Load Weather Data");
    }
  }

  Future<String>getCurrentCity() async{

    // Get Permission From User
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
    }

    // Fetch the current Location
    Position position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    
    // Convert the Location into a list of placemark Objects
    List<Placemark>placemark=await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract the City Name from the first placemark
    String? city=placemark[0].locality;

    return city??"";
  }
}