import 'package:flutter/material.dart';
import '../models/device_model.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  final VoidCallback onConnect;

  DeviceCard({required this.device, required this.onConnect});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          device.connectionType == 'Bluetooth' ? Icons.bluetooth : Icons.wifi,
          color: Colors.blue,
        ),
        title: Text(device.name),
        subtitle: Text('ID: ${device.id}'),
        trailing: ElevatedButton(
          onPressed: onConnect,
          child: Text(device.isConnected ? 'Connected' : 'Connect'),
        ),
      ),
    );
  }
}
