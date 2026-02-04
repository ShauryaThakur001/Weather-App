import 'package:flutter/material.dart';
import 'package:weatherrapp/Pages/Home/Home.dart';
import 'package:weatherrapp/Pages/Location%20Screen/LocationScreen.dart';
import 'package:weatherrapp/Pages/Profile%20Screen/ProfileScreen.dart';
import 'package:weatherrapp/Pages/Radar%20Screen/RadarScreen.dart';

class Bottomnavigationscreen extends StatefulWidget {
  const Bottomnavigationscreen({super.key});

  @override
  State<Bottomnavigationscreen> createState() => _BottomnavigationscreenState();
}

class _BottomnavigationscreenState extends State<Bottomnavigationscreen> {

  int index=0;

  List <>screens=[
    HomePage(),
    Locationscreen(),
    Radarscreen(),
    Profilescreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: ,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        setState(() {
          index=value;
        });
      },

      );
  }
}