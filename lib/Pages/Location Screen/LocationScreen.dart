import 'package:flutter/material.dart';

class Locationscreen extends StatefulWidget {
  const Locationscreen({super.key});

  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        leading: Icon(Icons.edit_location_alt_outlined, size: 30),
        centerTitle: true,
        title: Text(
          "Saved Locations",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.settings, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search for a city",
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 30,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 17,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                LocationWidget(city: 'London', weather: 'Cloudy', degree: '19', icon: Icons.cloud, color: Colors.blue,),
                LocationWidget(city: "New York", weather: "Sunny", degree: "24", icon: Icons.sunny, color: Colors.yellow),
                LocationWidget(city: "Tokyo", weather: "Rainy", degree: "21", icon: Icons.thunderstorm, color: Colors.blue),
                LocationWidget(city: "Paris", weather: "Clear Night", degree: "14", icon: Icons.cloud, color: Colors.grey),
                LocationWidget(city: "Sydney", weather: "Few Clouds", degree: "28", icon: Icons.sunny, color: Colors.orange)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {},
        child: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  final String city;
  final String weather;
  final String degree;
  final IconData icon;
  final MaterialColor color;
  const LocationWidget({
    super.key, required this.city, required this.weather, required this.degree, required this.icon, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Card(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(10),
          // height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 25),
            ),
            title: Text(
              city,
              style: TextStyle(fontSize: 20, fontFamily: "primaryFont"),
            ),
            subtitle: Text(weather,style: TextStyle(
              color: Colors.grey.shade700,
              fontFamily: "primaryFont"
            ),),
            trailing: Text(
              "$degree°C",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
