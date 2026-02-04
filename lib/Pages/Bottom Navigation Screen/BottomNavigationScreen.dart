import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherrapp/Pages/Home/Home.dart';
import 'package:weatherrapp/Pages/Location%20Screen/LocationScreen.dart';
import 'package:weatherrapp/Pages/Profile%20Screen/ProfileScreen.dart';
import 'package:weatherrapp/Pages/Radar%20Screen/RadarScreen.dart';
import 'package:weatherrapp/Providers/ThemeProvider.dart';

class Bottomnavigationscreen extends StatefulWidget {
  const Bottomnavigationscreen({super.key});

  @override
  State<Bottomnavigationscreen> createState() => _BottomnavigationscreenState();
}

class _BottomnavigationscreenState extends State<Bottomnavigationscreen> {


  int index=0;

  List <Widget>screens=[
    HomePage(),
    Locationscreen(),
    Radarscreen(),
    SettingScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    
  final themeProvider=context.watch<ThemeProvider>();

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeProvider.isDark?Colors.grey.shade900:Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Locations",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_sharp),
            label: "Map",
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            index=value;
          });
        },
      
        ),
    );
  }
}