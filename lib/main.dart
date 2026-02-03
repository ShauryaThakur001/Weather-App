import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weatherrapp/Pages/Home/Home.dart';
import 'package:weatherrapp/Pages/Login%20/LoginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Loginscreen(),
    );
  }
}