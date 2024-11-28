// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'dart:async';
//
// class BluetoothScanScreen extends StatefulWidget {
//   @override
//   _BluetoothScanScreenState createState() => _BluetoothScanScreenState();
// }
//
// class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
//   FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
//   List<BluetoothDiscoveryResult> _results = [];
//   bool _isDiscovering = false;
//   StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     _startDiscovery();
//   }
//
//   @override
//   void dispose() {
//     _discoveryStreamSubscription?.cancel();
//     super.dispose();
//   }
//
//   void _restartDiscovery() {
//     setState(() {
//       _results.clear();
//       _startDiscovery();
//     });
//   }
//
//   void _startDiscovery() {
//     setState(() {
//       _isDiscovering = true;
//     });
//
//     _discoveryStreamSubscription?.cancel();
//     _discoveryStreamSubscription = _bluetooth.startDiscovery().listen(
//       (BluetoothDiscoveryResult result) {
//         setState(() {
//           final existingIndex = _results.indexWhere(
//               (element) => element.device.address == result.device.address);
//           if (existingIndex >= 0) {
//             _results[existingIndex] = result;
//           } else {
//             _results.add(result);
//           }
//         });
//       },
//       onDone: () {
//         setState(() {
//           _isDiscovering = false;
//         });
//       },
//       onError: (error) {
//         setState(() {
//           _isDiscovering = false;
//         });
//         _showErrorSnackBar('Error discovering devices: $error');
//       },
//     );
//
//     // Automatically stop discovery after 30 seconds
//     Timer(Duration(seconds: 30), () {
//       if (_isDiscovering) {
//         _stopDiscovery();
//       }
//     });
//   }
//
//   Future<void> _stopDiscovery() async {
//     setState(() {
//       _isDiscovering = false;
//     });
//
//     _discoveryStreamSubscription?.cancel();
//     await _bluetooth.cancelDiscovery();
//   }
//
//   void _showErrorSnackBar(String message) {
//     if (!mounted) return;
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
//
//   String _getDeviceTypeName(BluetoothDevice device) {
//     switch (device.type) {
//       case BluetoothDeviceType.classic:
//         return 'Classic';
//       case BluetoothDeviceType.le:
//         return 'LE';
//       case BluetoothDeviceType.dual:
//         return 'Dual';
//       case BluetoothDeviceType.unknown:
//         return 'Unknown';
//       default:
//         return 'N/A';
//     }
//   }
//
//   Widget _buildDeviceListItem(BluetoothDiscoveryResult result) {
//     final device = result.device;
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       child: ListTile(
//         leading: Icon(
//           Icons.bluetooth,
//           color: Colors.blue,
//           size: 32,
//         ),
//         title: Text(
//           device.name ?? 'Unknown Device',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Address: ${device.address}'),
//             Text('Type: ${_getDeviceTypeName(device)}'),
//             Text('RSSI: ${result.rssi} dBm'),
//             Text('Bond State: ${device.bondState.toString().split('.').last}'),
//           ],
//         ),
//         trailing: Icon(Icons.chevron_right),
//         isThreeLine: true,
//         onTap: () {
//           // Handle device selection
//           print('Selected device: ${device.address}');
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bluetooth Scanner'),
//         actions: [
//           if (_isDiscovering)
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               ),
//             ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Discovery Control Button
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton.icon(
//               onPressed: _isDiscovering ? _stopDiscovery : _restartDiscovery,
//               icon: Icon(_isDiscovering ? Icons.stop : Icons.refresh),
//               label:
//                   Text(_isDiscovering ? 'Stop Discovery' : 'Restart Discovery'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: _isDiscovering ? Colors.red : Colors.blue,
//                 minimumSize: Size(double.infinity, 48),
//               ),
//             ),
//           ),
//
//           // Devices List
//           Expanded(
//             child: _results.isEmpty
//                 ? Center(
//                     child: Text(
//                       _isDiscovering
//                           ? 'Discovering devices...'
//                           : 'No devices found',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: _results.length,
//                     itemBuilder: (context, index) {
//                       return _buildDeviceListItem(_results[index]);
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart'; // For permission handling

class BluetoothScanScreen extends StatefulWidget {
  @override
  _BluetoothScanScreenState createState() => _BluetoothScanScreenState();
}

class _BluetoothScanScreenState extends State<BluetoothScanScreen> {
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDiscoveryResult> _results = [];
  bool _isDiscovering = false;
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void dispose() {
    _discoveryStreamSubscription?.cancel();
    super.dispose();
  }

  void _checkPermissions() async {
    // Check for Bluetooth and location permissions
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      _startDiscovery();
    } else {
      _showErrorSnackBar('Permission denied. Cannot scan for devices.');
    }
  }

  void _startDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _discoveryStreamSubscription?.cancel();
    _discoveryStreamSubscription = _bluetooth.startDiscovery().listen(
      (BluetoothDiscoveryResult result) {
        print('Discovered: ${result.device.name}, ${result.device.address}');
        setState(() {
          final existingIndex = _results.indexWhere(
              (element) => element.device.address == result.device.address);
          if (existingIndex >= 0) {
            _results[existingIndex] = result;
          } else {
            _results.add(result);
          }
        });
      },
      onDone: () {
        setState(() {
          _isDiscovering = false;
        });
        print("Discovery done");
      },
      onError: (error) {
        setState(() {
          _isDiscovering = false;
        });
        _showErrorSnackBar('Error discovering devices: $error');
      },
    );

    // Automatically stop discovery after 30 seconds
    Timer(Duration(seconds: 30), () {
      if (_isDiscovering) {
        _stopDiscovery();
      }
    });
  }

  Future<void> _stopDiscovery() async {
    setState(() {
      _isDiscovering = false;
    });
    _discoveryStreamSubscription?.cancel();
    await _bluetooth.cancelDiscovery();
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String _getDeviceTypeName(BluetoothDevice device) {
    switch (device.type) {
      case BluetoothDeviceType.classic:
        return 'Classic';
      case BluetoothDeviceType.le:
        return 'LE';
      case BluetoothDeviceType.dual:
        return 'Dual';
      case BluetoothDeviceType.unknown:
        return 'Unknown';
      default:
        return 'N/A';
    }
  }

  Widget _buildDeviceListItem(BluetoothDiscoveryResult result) {
    final device = result.device;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          Icons.bluetooth,
          color: Colors.blue,
          size: 32,
        ),
        title: Text(
          device.name ?? 'Unknown Device',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${device.address}'),
            Text('Type: ${_getDeviceTypeName(device)}'),
            Text('RSSI: ${result.rssi} dBm'),
            Text('Bond State: ${device.bondState.toString().split('.').last}'),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        isThreeLine: true,
        onTap: () {
          // Handle device selection
          print('Selected device: ${device.address}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Scanner'),
        actions: [
          if (_isDiscovering)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Discovery Control Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _isDiscovering ? _stopDiscovery : _startDiscovery,
              icon: Icon(_isDiscovering ? Icons.stop : Icons.refresh),
              label:
                  Text(_isDiscovering ? 'Stop Discovery' : 'Restart Discovery'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isDiscovering ? Colors.red : Colors.blue,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ),

          // Devices List
          Expanded(
            child: _results.isEmpty
                ? Center(
                    child: Text(
                      _isDiscovering
                          ? 'Discovering devices...'
                          : 'No devices found',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      return _buildDeviceListItem(_results[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
