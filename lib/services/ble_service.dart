import 'package:flutter_blue/flutter_blue.dart';

class BleService {
  Future<List<String>> discoverDevices() async {
    try {
      FlutterBlue flutterBlue = FlutterBlue.instance;

      // Check Bluetooth state
      var isOn = await flutterBlue.isOn;
      if (!isOn) {
        return ['Bluetooth is off. Please enable it.'];
      }

      // Start scanning
      flutterBlue.startScan(timeout: Duration(seconds: 4));
      List<ScanResult> results = await flutterBlue.scanResults.first;

      // Collect device names
      List<String> devices = results.map((result) {
        return result.device.name.isNotEmpty
            ? result.device.name
            : 'Unknown Device';
      }).toList();

      flutterBlue.stopScan();
      return devices.isNotEmpty ? devices : ['No devices found.'];
    } catch (e) {
      return ['Error discovering devices: $e'];
    }
  }
}
