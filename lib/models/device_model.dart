class Device {
  final String name;
  final String id; // Device ID
  final String connectionType; // Bluetooth or Wi-Fi
  bool isConnected;

  // Sensor data for the device
  double heartRate;
  double spo2;
  double temperature;

  Device({
    required this.name,
    required this.id,
    required this.connectionType,
    this.isConnected = false,
    this.heartRate = 0.0,
    this.spo2 = 0.0,
    this.temperature = 0.0,
  });
}
