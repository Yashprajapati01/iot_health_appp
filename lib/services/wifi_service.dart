import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class WifiService {
  Future<List<String>> discoverDevices() async {
    try {
      final wifiName = await WifiInfo().getWifiName();
      if (wifiName == null || wifiName.isEmpty) {
        return ['No Wi-Fi network found.'];
      }

      // Return mock device list for simplicity
      return [
        '$wifiName Device 1',
        '$wifiName Device 2',
      ];
    } catch (e) {
      return ['Error discovering Wi-Fi devices: $e'];
    }
  }
}
