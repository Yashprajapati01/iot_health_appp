import 'package:permission_handler/permission_handler.dart';

Future<void> requestBluetoothPermissions() async {
  final bluetoothStatus = await Permission.bluetooth.status;
  final locationStatus = await Permission.location.status;

  if (bluetoothStatus.isDenied) {
    await Permission.bluetooth.request();
  }
  if (locationStatus.isDenied) {
    await Permission.location.request();
  }

  if (bluetoothStatus.isPermanentlyDenied ||
      locationStatus.isPermanentlyDenied) {
    openAppSettings();
  }
}
