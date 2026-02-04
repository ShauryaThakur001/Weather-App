import 'package:geolocator/geolocator.dart';

class LocationPermissionService {

  static Future<bool> requestPermission() async {
    try {
      // 1️⃣ Check if GPS is ON
      bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      // 2️⃣ Check permission
      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // 3️⃣ Final result
      return permission == LocationPermission.whileInUse ||
             permission == LocationPermission.always;

    } catch (e) {
      print("Location permission error: $e");
      return false;
    }
  }

  static Future<void> openSettings() async {
    await Geolocator.openAppSettings();
  }
}
