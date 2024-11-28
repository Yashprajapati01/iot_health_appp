import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiScanScreen extends StatefulWidget {
  @override
  _WifiScanScreenState createState() => _WifiScanScreenState();
}

class _WifiScanScreenState extends State<WifiScanScreen> {
  List<WifiNetwork> _networks = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    scanWifiNetworks();
  }

  Future<void> scanWifiNetworks() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
      _networks = [];
    });

    try {
      // Check if WiFi is enabled
      bool isEnabled = await WiFiForIoTPlugin.isEnabled();
      if (!isEnabled) {
        throw Exception('WiFi is not enabled');
      }

      // Scan for networks
      List<dynamic> results = await WiFiForIoTPlugin.loadWifiList();

      List<WifiNetwork> networks = results.map((result) {
        // Convert the dynamic result to a Map<String, dynamic>
        Map<String, dynamic> networkMap = Map<String, dynamic>.from(result);

        return WifiNetwork(
          ssid: networkMap['SSID'] as String? ?? 'Unknown',
          bssid: networkMap['BSSID'] as String? ?? '',
          level: networkMap['level'] as int? ?? 0,
          frequency: networkMap['frequency'] as int? ?? 0,
          capabilities: networkMap['capabilities'] as String? ?? '',
        );
      }).toList();

      if (mounted) {
        setState(() {
          _networks = networks;
          _isScanning = false;
        });
      }
    } catch (e) {
      print("Error scanning Wi-Fi: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error scanning Wi-Fi networks: $e')),
        );
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wi-Fi Scan"),
        actions: [
          if (_isScanning)
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: _isScanning ? null : scanWifiNetworks,
              icon: Icon(_isScanning ? Icons.stop : Icons.refresh),
              label: Text(_isScanning ? "Scanning..." : "Restart the Scanning"),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isScanning ? Colors.red : Colors.blue,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ),
          Expanded(
            child: _networks.isEmpty
                ? Center(
                    child: Text(_isScanning
                        ? 'Scanning for networks...'
                        : 'No networks found'),
                  )
                : ListView.builder(
                    itemCount: _networks.length,
                    itemBuilder: (context, index) {
                      var network = _networks[index];
                      return ListTile(
                        leading: Icon(Icons.wifi),
                        title: Text(network.ssid),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Signal Strength: ${network.level} dBm"),
                            Text("Frequency: ${network.frequency} MHz"),
                            Text("Security: ${network.capabilities}"),
                          ],
                        ),
                        trailing: Icon(
                          Icons.signal_wifi_4_bar,
                          color: _getSignalColor(network.level),
                        ),
                        isThreeLine: true,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color _getSignalColor(int level) {
    if (level >= -50) return Colors.green;
    if (level >= -60) return Colors.lightGreen;
    if (level >= -70) return Colors.yellow;
    return Colors.orange;
  }
}

class WifiNetwork {
  final String ssid;
  final String bssid;
  final int level;
  final int frequency;
  final String capabilities;

  WifiNetwork({
    required this.ssid,
    required this.bssid,
    required this.level,
    required this.frequency,
    required this.capabilities,
  });
}
