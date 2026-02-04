import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionService {

  static Future<bool> requestPermission() async {
    PermissionStatus status = await Permission.notification.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      PermissionStatus result =
          await Permission.notification.request();
      return result.isGranted;
    }

    if (status.isPermanentlyDenied) {
      return false;
    }

    return false;
  }

  /// 🔥 THIS WAS MISSING
  static Future<void> openSettings() async {
    await openAppSettings();
  }
}
