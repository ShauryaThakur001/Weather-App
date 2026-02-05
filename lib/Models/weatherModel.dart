class Weathermodel {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weathermodel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  factory Weathermodel.fromJson(Map<String,dynamic>json){
    return Weathermodel(
      cityName: json['name'], 
      temperature: json['main']['temp'].toDouble(), 
      mainCondition: json['weather'][0]['main']);
  }
}
