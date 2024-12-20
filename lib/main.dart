import 'package:flutter/material.dart';
import 'package:iot_health_appp/screens/data_visualization_screen.dart';
import 'package:iot_health_appp/screens/device_list_screen.dart';
import 'package:iot_health_appp/utils/theme.dart';
import 'package:iot_health_appp/screens/bluetooth_scan_screen.dart';
import 'package:iot_health_appp/screens/wifi_scan_screen.dart';

import 'models/device_model.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/device-list': (context) => DeviceListScreen(
              connectionType:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
        '/bluetooth-scanning': (context) => BluetoothScanScreen(),
        '/wifi-scanning': (context) => WifiScanScreen(),
        '/data-visualization': (context) => DataVisualizationScreen(
              device: ModalRoute.of(context)?.settings.arguments as Device,
            ),
      },
    );
  }
}
