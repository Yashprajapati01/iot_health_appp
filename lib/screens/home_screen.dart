import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _deviceNameController = TextEditingController();
  String _connectionType = 'Bluetooth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IoT Health App'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Device Name Input Button
            ElevatedButton(
              onPressed: () => _showDeviceNameInputDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _deviceNameController.text.isEmpty
                    ? 'Enter Device Name'
                    : 'Device: ${_deviceNameController.text}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Compact Dropdown
            DropdownButton<String>(
              value: _connectionType,
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white, fontSize: 16),
              items: [
                DropdownMenuItem(
                  value: 'Bluetooth',
                  child: Row(
                    children: [
                      Icon(Icons.bluetooth, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Bluetooth'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Wi-Fi',
                  child: Row(
                    children: [
                      Icon(Icons.wifi, color: Colors.green),
                      SizedBox(width: 10),
                      Text('Wi-Fi'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _connectionType = value!;
                });
              },
            ),
            SizedBox(height: 40),

            // Action Cards for Connection Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionCard(
                  icon: Icons.bluetooth,
                  title: 'Bluetooth',
                  color: Colors.blueAccent,
                  onTap: () {
                    Navigator.pushNamed(context, '/device-list',
                        arguments: 'Bluetooth');
                  },
                ),
                ActionCard(
                  icon: Icons.wifi,
                  title: 'Wi-Fi',
                  color: Colors.greenAccent,
                  onTap: () {
                    Navigator.pushNamed(context, '/device-list',
                        arguments: 'Wi-Fi');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Show Dialog for Device Name Input
  void _showDeviceNameInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Enter Device Name',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _deviceNameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white12,
              hintText: 'Device Name',
              hintStyle: TextStyle(color: Colors.white38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {}); // Update UI after input
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

// Action Card Widget
class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  ActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black.withOpacity(0.7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        child: Container(
          width: 140,
          height: 160,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                radius: 32,
                child: Icon(icon, size: 36, color: color),
              ),
              SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
