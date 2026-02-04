import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherrapp/Firebase/Auth_Service.dart';
import 'package:weatherrapp/Pages/Auth/LoginScreen.dart';
import 'package:weatherrapp/Providers/ThemeProvider.dart';
import 'package:weatherrapp/Services/Location_Permission_Service.dart';
import 'package:weatherrapp/Services/Notification_Permission_Service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();

  bool isNotification = false;
  bool isLocationAccess = false;

  bool isCelsius = true;
  bool isKmPerHour = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: themeProvider.isDark
          ? Colors.grey.shade900
          : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        backgroundColor: themeProvider.isDark
            ? Colors.grey.shade800
            : Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------- Appearance & Alerts ----------------
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 22, bottom: 6),
                child: Text(
                  "Appearance & Alerts",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),

              _switchTile(
                icon: Icons.dark_mode,
                title: "Dark Mode",
                value: themeProvider.isDark,
                onChanged: (_) => context.read<ThemeProvider>().toggleTheme(),
              ),

              _switchTile(
                icon: Icons.notifications,
                title: "Notifications",
                value: isNotification,
                onChanged: (value) async {
                  if (value) {
                    bool granted =
                        await NotificationPermissionService.requestPermission();

                    if (granted) {
                      setState(() => isNotification = true);
                    } else {
                      setState(() => isNotification = false);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Enable notifications from app settings to get alerts",
                          ),
                          action: SnackBarAction(
                            label: "OPEN",
                            onPressed: () {
                              NotificationPermissionService.openSettings();
                            },
                          ),
                        ),
                      );
                    }
                  } else {
                    setState(() => isNotification = false);
                  }
                },
              ),

              _switchTile(
                icon: Icons.location_on,
                title: "Location Access",
                value: isLocationAccess,
                onChanged: (value) async {
                  if (value) {
                    bool granted =
                        await LocationPermissionService.requestPermission();

                    if (granted) {
                      setState(() => isLocationAccess = true);
                    } else {
                      setState(() => isLocationAccess = false);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Enable location services to get local weather",
                          ),
                          action: SnackBarAction(
                            label: "SETTINGS",
                            onPressed: () {
                              LocationPermissionService.openSettings();
                            },
                          ),
                        ),
                      );
                    }
                  } else {
                    setState(() => isLocationAccess = false);
                  }
                },
              ),

              /// ---------------- Units ----------------
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 26, bottom: 6),
                child: Text(
                  "Units",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),

              _unitTile(
                icon: Icons.thermostat,
                title: "Temperature",
                trailing: unitToggle(
                  leftSelected: isCelsius,
                  leftText: "°C",
                  rightText: "°F",
                  onChanged: (v) => setState(() => isCelsius = v),
                ),
              ),

              _unitTile(
                icon: Icons.air_rounded,
                title: "Wind Speed",
                trailing: unitToggle(
                  leftSelected: isKmPerHour,
                  leftText: "km/h",
                  rightText: "mph",
                  onChanged: (v) => setState(() => isKmPerHour = v),
                ),
              ),

              _unitTile(
                icon: Icons.public,
                title: "Language",
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "English",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ],
                ),
              ),

              /// ---------------- Account ----------------
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 26, bottom: 6),
                child: Text(
                  "Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),

              _simpleTile(
                icon: Icons.person,
                title: "Edit Profile",
                titleColor: themeProvider.isDark ? Colors.white : Colors.black,
                iconColor: themeProvider.isDark ? Colors.white : Colors.black,
              ),

              GestureDetector(
                onTap: () async {
                  await _authService.logOut();
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const Loginscreen()),
                  );
                },
                child: _simpleTile(
                  icon: Icons.logout,
                  title: "Sign Out",
                  titleColor: Colors.red,
                  iconColor: Colors.red,
                ),
              ),

              /// ---------------- Support ----------------
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 26, bottom: 6),
                child: Text(
                  "Support & Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),

              _simpleTile(
                icon: Icons.help,
                title: "Help Center",
                iconColor: themeProvider.isDark ? Colors.white : Colors.black,
                titleColor: themeProvider.isDark ? Colors.white : Colors.black,
              ),
              _simpleTile(
                icon: Icons.policy,
                title: "Privacy Policy",
                iconColor: themeProvider.isDark ? Colors.white : Colors.black,
                titleColor: themeProvider.isDark ? Colors.white : Colors.black,
              ),
              _simpleTile(
                icon: Icons.info_rounded,
                title: "About",
                iconColor: themeProvider.isDark ? Colors.white : Colors.black,
                titleColor: themeProvider.isDark ? Colors.white : Colors.black,
              ),

              const SizedBox(height: 30),

              Center(
                child: Column(
                  children: const [
                    Text(
                      "Version 1.0.0  (Build 108)",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "© 2026 WeatherApp Inc.",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- Reusable Widgets ----------------

Widget _switchTile({
  required IconData icon,
  required String title,
  required bool value,
  required Function(bool) onChanged,
}) {
  return ListTile(
    minVerticalPadding: 14,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    visualDensity: const VisualDensity(vertical: 1.2),
    leading: _iconBox(icon),
    title: Text(title, style: const TextStyle(fontSize: 18)),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white,
      activeTrackColor: Colors.blue,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey.shade400,
    ),
  );
}

Widget _unitTile({
  required IconData icon,
  required String title,
  required Widget trailing,
}) {
  return ListTile(
    minVerticalPadding: 14,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    visualDensity: const VisualDensity(vertical: 1.2),
    leading: _iconBox(icon),
    title: Text(title, style: const TextStyle(fontSize: 18)),
    trailing: trailing,
  );
}

Widget _simpleTile({
  required IconData icon,
  required String title,
  Color titleColor = Colors.black,
  Color iconColor = Colors.black,
}) {
  return ListTile(
    minVerticalPadding: 14,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    visualDensity: const VisualDensity(vertical: 1.2),
    leading: Icon(icon, color: iconColor),
    title: Text(title, style: TextStyle(fontSize: 18, color: titleColor)),
    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
  );
}

Widget _iconBox(IconData icon) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
      color: const Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(icon, color: Colors.blue, size: 25),
  );
}

/// ---------------- Unit Toggle ----------------

Widget unitToggle({
  required bool leftSelected,
  required String leftText,
  required String rightText,
  required Function(bool) onChanged,
}) {
  return Container(
    height: 40,
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(22),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => onChanged(true),
          child: _toggleItem(text: leftText, selected: leftSelected),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: () => onChanged(false),
          child: _toggleItem(text: rightText, selected: !leftSelected),
        ),
      ],
    ),
  );
}

Widget _toggleItem({required String text, required bool selected}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
    decoration: BoxDecoration(
      color: selected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      boxShadow: selected
          ? const [BoxShadow(color: Colors.black12, blurRadius: 4)]
          : null,
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: selected ? Colors.black : Colors.grey,
      ),
    ),
  );
}
