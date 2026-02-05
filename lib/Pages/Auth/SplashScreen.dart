import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weatherrapp/Pages/Auth/LoginScreen.dart';
import 'package:weatherrapp/Pages/Bottom%20Navigation%20Screen/BottomNavigationScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Bottomnavigationscreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Loginscreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8F6FF),
            Color(0xFFD6EEFF),
            Color(0xFFC6E6FF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              // CENTER IMAGE
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 350,
                  ),
                ),
              ),

              // BOTTOM CONTENT
              Column(
                children: [
                  const Text(
                    "Weatherly",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your daily sky companion",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const LinearProgressIndicator(
                    minHeight: 5,
                    backgroundColor: Color(0xFFBEE3FF),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF4A90E2),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
