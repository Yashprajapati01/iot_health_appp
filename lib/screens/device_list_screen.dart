import 'package:flutter/material.dart';
import '../models/device_model.dart';

class DeviceListScreen extends StatelessWidget {
  final String connectionType;

  DeviceListScreen({required this.connectionType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${connectionType} Devices')),
      body: ListView.builder(
        itemCount: 5, // Mock data, replace with actual device list
        itemBuilder: (context, index) {
          final device = Device(
            name: 'Device $index',
            id: 'Device${index + 1}',
            connectionType: connectionType,
            isConnected: false, // All devices start in "Connect" state
          );
          return DeviceCard(
            device: device,
            onConnect: () {
              // When the user taps, mark it as connected
              device.isConnected = true;
              Navigator.pushNamed(context, '/data-visualization',
                  arguments: device);
            },
          );
        },
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final Device device;
  final VoidCallback onConnect;

  DeviceCard({required this.device, required this.onConnect});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        leading: Icon(
          device.connectionType == 'Bluetooth' ? Icons.bluetooth : Icons.wifi,
          color: Colors.blue,
        ),
        title: Text(device.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(device.connectionType),
        trailing: TextButton(
          onPressed: onConnect,
          style: TextButton.styleFrom(
            foregroundColor: device.isConnected ? Colors.green : Colors.blue,
          ),
          child: Text(device.isConnected ? 'Connected' : 'Connect'),
        ),
      ),
    );
  }
}
