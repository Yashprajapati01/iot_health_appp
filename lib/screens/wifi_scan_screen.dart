import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiScanScreen extends StatefulWidget {
  @override
  _WifiScanScreenState createState() => _WifiScanScreenState();
}

class _WifiScanScreenState extends State<WifiScanScreen> {
  List<WifiNetwork> _networks = [];
  bool _isScanning = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _startInitialScan();
  }

  Future<void> _startInitialScan() async {
    // Add a small delay before starting the initial scan
    await Future.delayed(Duration(milliseconds: 500));
    scanWifiNetworks();
  }

  Future<void> scanWifiNetworks() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
      _hasError = false;
    });

    try {
      // Check if WiFi is enabled
      bool isEnabled = await WiFiForIoTPlugin.isEnabled();
      if (!isEnabled) {
        throw Exception('WiFi is not enabled');
      }

      // Add a minimum scanning time to show the scanning state
      await Future.delayed(Duration(seconds: 2));

      // Scan for networks
      List<WifiNetwork> networks = [];
      List<dynamic> results = await WiFiForIoTPlugin.loadWifiList();

      // Add another small delay to ensure results are processed
      await Future.delayed(Duration(milliseconds: 500));

      for (var result in results) {
        if (result is Map<String, dynamic>) {
          networks.add(WifiNetwork(
            ssid: result['SSID']?.toString() ?? 'Unknown',
            bssid: result['BSSID']?.toString() ?? '',
            level: result['level'] is int ? result['level'] : 0,
            frequency: result['frequency'] is int ? result['frequency'] : 0,
            capabilities: result['capabilities']?.toString() ?? '',
          ));
        }
      }

      // Sort networks by signal strength
      networks.sort((a, b) => b.level.compareTo(a.level));

      if (mounted) {
        setState(() {
          _networks = networks;
          _isScanning = false;
        });
      }
    } catch (e) {
      print("Error scanning Wi-Fi: $e");
      if (mounted) {
        setState(() {
          _isScanning = false;
          _hasError = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error scanning Wi-Fi networks: $e'),
            duration: Duration(seconds: 3),
          ),
        );
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
      body: RefreshIndicator(
        onRefresh: scanWifiNetworks,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: _isScanning ? null : scanWifiNetworks,
                icon: Icon(_isScanning ? Icons.wifi_find : Icons.refresh),
                label: Text(_isScanning ? "Scanning..." : "Scan for Networks"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isScanning ? Colors.grey : Colors.blue,
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
            ),
            Expanded(
              child: _buildNetworkList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkList() {
    if (_isScanning && _networks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Scanning for networks...'),
          ],
        ),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red),
            SizedBox(height: 16),
            Text('Error scanning networks'),
            SizedBox(height: 8),
            Text('Pull down to try again',
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (_networks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text('No networks found'),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _networks.length,
      itemBuilder: (context, index) {
        var network = _networks[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: Icon(
              Icons.wifi,
              color: _getSignalColor(network.level),
            ),
            title: Text(
              network.ssid,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Signal: ${network.level} dBm"),
                Text("Frequency: ${network.frequency} MHz"),
                Text(
                  "Security: ${_getSecurityType(network.capabilities)}",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: _buildSignalStrengthIndicator(network.level),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  Widget _buildSignalStrengthIndicator(int level) {
    int bars = _getSignalBars(level);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return Icon(
          index < bars ? Icons.signal_wifi_4_bar : Icons.signal_wifi_0_bar,
          size: 16,
          color: index < bars ? _getSignalColor(level) : Colors.grey[300],
        );
      }),
    );
  }

  int _getSignalBars(int level) {
    if (level >= -50) return 4;
    if (level >= -60) return 3;
    if (level >= -70) return 2;
    return 1;
  }

  Color _getSignalColor(int level) {
    if (level >= -50) return Colors.green;
    if (level >= -60) return Colors.lightGreen;
    if (level >= -70) return Colors.yellow;
    return Colors.orange;
  }

  String _getSecurityType(String capabilities) {
    if (capabilities.contains("WPA3")) return "WPA3";
    if (capabilities.contains("WPA2")) return "WPA2";
    if (capabilities.contains("WPA")) return "WPA";
    if (capabilities.contains("WEP")) return "WEP";
    return "Open";
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
