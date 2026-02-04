import 'package:flutter/material.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  bool isDark = false;
  bool isNotification = false;
  bool isLocationAccess = false;

  bool isCelsius = true;
  bool isKmPerHour = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        backgroundColor: Colors.white,
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
                value: isDark,
                onChanged: (v) => setState(() => isDark = v),
              ),

              _switchTile(
                icon: Icons.notifications,
                title: "Notifications",
                value: isNotification,
                onChanged: (v) => setState(() => isNotification = v),
              ),

              _switchTile(
                icon: Icons.location_on,
                title: "Location Access",
                value: isLocationAccess,
                onChanged: (v) => setState(() => isLocationAccess = v),
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
                    Text("English", style: TextStyle(color: Colors.grey)),
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
              ),

              _simpleTile(
                icon: Icons.logout,
                title: "Sign Out",
                titleColor: Colors.red,
                iconColor: Colors.red,
              ),

              /// ---------------- Support ----------------
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 26, bottom: 6),
                child: Text(
                  "Support & Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
              ),

              _simpleTile(icon: Icons.help, title: "Help Center"),
              _simpleTile(icon: Icons.policy, title: "Privacy Policy"),
              _simpleTile(icon: Icons.info_rounded, title: "About"),

              const SizedBox(height: 30),

              Center(
                child: Column(
                  children: [
                    Text("Version 1.0.0 (Build 108)",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                    ),),
                    Text("© 2026 WeatherApp Inc.",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                    ),),
                    
                  ],
                ),
              ),
              SizedBox(height: 30,)
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
    minVerticalPadding: 14, // ⬆️ KEY FIX
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    visualDensity: const VisualDensity(vertical: 1.2), // ⬆️ more air
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
    title: Text(
      title,
      style: TextStyle(fontSize: 18, color: titleColor),
    ),
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

Widget _toggleItem({
  required String text,
  required bool selected,
}) {
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
