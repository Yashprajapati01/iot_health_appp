// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wifi_iot/wifi_iot.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _deviceNameController = TextEditingController();
//   String _connectionType = 'Bluetooth';
//
//   Future<void> checkAndRequestBluetooth(BuildContext context) async {
//     // Request Bluetooth permissions
//     if (await Permission.bluetooth.request().isGranted &&
//         await Permission.bluetoothScan.request().isGranted &&
//         await Permission.bluetoothConnect.request().isGranted) {
//       // Check Bluetooth state
//       final bluetoothState = await FlutterBluePlus.adapterState.first;
//       if (bluetoothState == BluetoothAdapterState.on) {
//         debugPrint("Bluetooth is already enabled.");
//         // Navigate to Bluetooth scanning page
//         Navigator.pushNamed(context, '/bluetooth-scanning');
//       } else {
//         debugPrint("Bluetooth is not enabled. Prompting user to enable it...");
//         FlutterBluePlus.turnOn(); // Requests turning on Bluetooth
//       }
//     } else {
//       debugPrint("Bluetooth permissions not granted.");
//     }
//   }
//
//   Future<void> checkAndRequestWifi(BuildContext context) async {
//     // Check if Wi-Fi is enabled
//     bool isWifiEnabled = await WiFiForIoTPlugin.isEnabled();
//
//     if (!isWifiEnabled) {
//       // If Wi-Fi is turned off, show a dialog prompting to enable Wi-Fi
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Wi-Fi is Disabled'),
//             content: const Text('Please enable Wi-Fi to continue.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       debugPrint("Wi-Fi is already enabled.");
//       // Navigate to Wi-Fi scanning page
//       Navigator.pushNamed(context, '/wifi-scanning');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('IoT Health App'),
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _deviceNameController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         labelText: 'Device Name',
//                         labelStyle: TextStyle(color: Colors.white70),
//                         hintText: 'Enter Device Name',
//                         hintStyle: TextStyle(color: Colors.white38),
//                         filled: true,
//                         fillColor: Colors.white12,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         _showDropdownSelector(context);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         height: 56,
//                         decoration: BoxDecoration(
//                           color: Colors.white12,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.white38),
//                         ),
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           children: [
//                             Icon(
//                               _connectionType == 'Bluetooth'
//                                   ? Icons.bluetooth
//                                   : Icons.wifi,
//                               color: _connectionType == 'Bluetooth'
//                                   ? Colors.blue
//                                   : Colors.green,
//                             ),
//                             SizedBox(width: 8),
//                             Text(
//                               _connectionType,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 _handleSubmit();
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                 backgroundColor: Colors.blueAccent,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: Text(
//                 'Submit',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//             SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ActionCard(
//                   icon: Icons.bluetooth,
//                   title: 'Bluetooth',
//                   color: Colors.blueAccent,
//                   onTap: () {
//                     checkAndRequestBluetooth(context);
//                   },
//                 ),
//                 ActionCard(
//                   icon: Icons.wifi,
//                   title: 'Wi-Fi',
//                   color: Colors.greenAccent,
//                   onTap: () {
//                     checkAndRequestWifi(context);
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showDropdownSelector(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: Colors.black,
//           title: Text(
//             'Select Connection Type',
//             style: TextStyle(color: Colors.white),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Icon(Icons.bluetooth, color: Colors.blue),
//                 title: Text('Bluetooth', style: TextStyle(color: Colors.white)),
//                 onTap: () {
//                   setState(() {
//                     _connectionType = 'Bluetooth';
//                   });
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.wifi, color: Colors.green),
//                 title: Text('Wi-Fi', style: TextStyle(color: Colors.white)),
//                 onTap: () {
//                   setState(() {
//                     _connectionType = 'Wi-Fi';
//                   });
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _handleSubmit() {
//     if (_deviceNameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           duration: Duration(seconds: 1),
//           content: Text('Device Name is required'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
//
//     if (_connectionType == 'Bluetooth') {
//       Navigator.pushNamed(context, '/device-list', arguments: 'Bluetooth');
//     } else if (_connectionType == 'Wi-Fi') {
//       Navigator.pushNamed(context, '/device-list', arguments: 'Wi-Fi');
//     } else {
//       print('No valid connection type selected');
//     }
//   }
// }
//
// class ActionCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Color color;
//   final VoidCallback onTap;
//
//   ActionCard({
//     required this.icon,
//     required this.title,
//     required this.color,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         color: Colors.black.withOpacity(0.7),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 10,
//         child: Container(
//           width: 140,
//           height: 160,
//           padding: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 backgroundColor: color.withOpacity(0.2),
//                 radius: 32,
//                 child: Icon(icon, size: 36, color: color),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _deviceNameController = TextEditingController();
  String _connectionType = 'Bluetooth';

  Future<void> checkAndRequestBluetooth(BuildContext context) async {
    if (await Permission.bluetooth.request().isGranted &&
        await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      final bluetoothState = await FlutterBluePlus.adapterState.first;
      if (bluetoothState == BluetoothAdapterState.on) {
        Navigator.pushNamed(context, '/bluetooth-scanning');
      } else {
        FlutterBluePlus.turnOn();
      }
    }
  }

  Future<void> checkAndRequestWifi(BuildContext context) async {
    bool isWifiEnabled = await WiFiForIoTPlugin.isEnabled();
    if (!isWifiEnabled) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Wi-Fi is Disabled'),
            content: const Text('Please enable Wi-Fi to continue.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pushNamed(context, '/wifi-scanning');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IoT Health App',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF1E88E5),
        centerTitle: true,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1D1E33), Color(0xFF111328)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Control Your Devices',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Easily connect and manage your IoT devices using Bluetooth or Wi-Fi.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 20),

              // Device Name Input Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Setup',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _deviceNameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Device Name',
                        labelStyle: TextStyle(color: Colors.white70),
                        hintText: 'Enter Device Name',
                        hintStyle: TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: Colors.black26,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _showDropdownSelector(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white38),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _connectionType,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(
                              _connectionType == 'Bluetooth'
                                  ? Icons.bluetooth
                                  : Icons.wifi,
                              color: _connectionType == 'Bluetooth'
                                  ? Colors.blue
                                  : Colors.green,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Real Device Control Section
              Text(
                'Real-Time Control',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionCard(
                    icon: Icons.bluetooth,
                    title: 'Bluetooth',
                    color: Colors.blueAccent,
                    onTap: () => checkAndRequestBluetooth(context),
                  ),
                  _buildActionCard(
                    icon: Icons.wifi,
                    title: 'Wi-Fi',
                    color: Colors.greenAccent,
                    onTap: () => checkAndRequestWifi(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white24,
              radius: 36,
              child: Icon(icon, size: 40, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdownSelector(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Select Connection Type',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.bluetooth, color: Colors.blue),
                title: Text('Bluetooth', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _connectionType = 'Bluetooth';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.wifi, color: Colors.green),
                title: Text('Wi-Fi', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _connectionType = 'Wi-Fi';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSubmit() {
    if (_deviceNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Device Name is required'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/device-list',
      arguments: _connectionType,
    );
  }
}
