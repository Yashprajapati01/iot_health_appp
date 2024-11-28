import 'package:flutter/material.dart';
import '../models/device_model.dart';

class DeviceListScreen extends StatefulWidget {
  final String connectionType;

  DeviceListScreen({required this.connectionType});

  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  // List to hold device objects
  late List<Device> devices;

  @override
  void initState() {
    super.initState();
    // Initialize the devices list
    devices = List.generate(
      5,
      (index) => Device(
        name: 'Device $index',
        id: 'Device${index + 1}',
        connectionType: widget.connectionType,
        isConnected: false, // Initially all devices are not connected
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.connectionType} Devices')),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return DeviceCard(
            device: device,
            onConnectToggle: () {
              setState(() {
                device.isConnected =
                    !device.isConnected; // Toggle connection state
              });
            },
          );
        },
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  final Device device;
  final VoidCallback onConnectToggle;

  DeviceCard({required this.device, required this.onConnectToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (device.isConnected) {
          Navigator.pushNamed(
            context,
            '/data-visualization',
            arguments: device,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please connect the device before proceeding.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        child: ListTile(
          leading: Icon(
            device.connectionType == 'Bluetooth' ? Icons.bluetooth : Icons.wifi,
            color: Colors.blue,
          ),
          title: Text(
            device.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(device.connectionType),
          trailing: TextButton(
            onPressed: onConnectToggle,
            style: TextButton.styleFrom(
              foregroundColor: device.isConnected ? Colors.green : Colors.blue,
            ),
            child: Text(
              device.isConnected ? 'Disconnect' : 'Connect',
              style: TextStyle(
                color: device.isConnected ? Colors.green : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
