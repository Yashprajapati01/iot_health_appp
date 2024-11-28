// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../models/device_model.dart';
//
// class DataVisualizationScreen extends StatefulWidget {
//   final Device device;
//
//   DataVisualizationScreen({required this.device});
//
//   @override
//   _DataVisualizationScreenState createState() =>
//       _DataVisualizationScreenState();
// }
//
// class _DataVisualizationScreenState extends State<DataVisualizationScreen> {
//   late List<ChartData> heartRateData;
//   late List<ChartData> spo2Data;
//   late List<ChartData> temperatureData;
//   int _counter = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     heartRateData = [];
//     spo2Data = [];
//     temperatureData = [];
//     _startDataUpdate();
//   }
//
//   void _startDataUpdate() {
//     // Simulating live data update every 5 seconds
//     Future.delayed(Duration(seconds: 5), () {
//       setState(() {
//         // Simulate random data for each metric
//         heartRateData.add(ChartData(_counter.toDouble(), 60 + _counter % 40));
//         spo2Data.add(ChartData(_counter.toDouble(), 95 + _counter % 5));
//         temperatureData
//             .add(ChartData(_counter.toDouble(), 36.5 + _counter % 2));
//
//         _counter++;
//         if (heartRateData.length > 20) heartRateData.removeAt(0);
//         if (spo2Data.length > 20) spo2Data.removeAt(0);
//         if (temperatureData.length > 20) temperatureData.removeAt(0);
//       });
//       _startDataUpdate(); // Keep updating
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Text('Data Visualization for ${widget.device.name}',
//             maxLines: 2, overflow: TextOverflow.ellipsis),
//         backgroundColor: Colors.transparent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             // Heart Rate Card
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 8,
//               child: ListTile(
//                 title: Text('Heart Rate', style: TextStyle(fontSize: 18)),
//                 subtitle: Text(
//                     'Latest Value: ${heartRateData.isEmpty ? 'N/A' : heartRateData.last.y.toStringAsFixed(2)} BPM'),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // SpO2 Card
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 8,
//               child: ListTile(
//                 title: Text('SpO2', style: TextStyle(fontSize: 18)),
//                 subtitle: Text(
//                     'Latest Value: ${spo2Data.isEmpty ? 'N/A' : spo2Data.last.y.toStringAsFixed(2)} %'),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Temperature Card
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 8,
//               child: ListTile(
//                 title: Text('Temperature', style: TextStyle(fontSize: 18)),
//                 subtitle: Text(
//                     'Latest Value: ${temperatureData.isEmpty ? 'N/A' : temperatureData.last.y.toStringAsFixed(2)} °C'),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // Chart displaying Heart Rate over Time
//             Expanded(
//               child: SfCartesianChart(
//                 primaryXAxis: NumericAxis(),
//                 title: ChartTitle(text: 'Statistics'),
//                 legend: Legend(isVisible: true),
//                 series: <LineSeries<ChartData, double>>[
//                   LineSeries<ChartData, double>(
//                     name: 'Heart Rate',
//                     dataSource: heartRateData,
//                     xValueMapper: (ChartData data, _) => data.x,
//                     yValueMapper: (ChartData data, _) => data.y,
//                     color: Colors.blue,
//                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                   ),
//                   LineSeries<ChartData, double>(
//                     name: 'SpO2',
//                     dataSource: spo2Data,
//                     xValueMapper: (ChartData data, _) => data.x,
//                     yValueMapper: (ChartData data, _) => data.y,
//                     color: Colors.green,
//                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                   ),
//                   LineSeries<ChartData, double>(
//                     name: 'Temperature',
//                     dataSource: temperatureData,
//                     xValueMapper: (ChartData data, _) => data.x,
//                     yValueMapper: (ChartData data, _) => data.y,
//                     color: Colors.red,
//                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ChartData {
//   final double x; // Represents time or data index
//   final double
//       y; // Represents sensor value (e.g., heart rate, SpO2, temperature)
//
//   ChartData(this.x, this.y);
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/device_model.dart';

class DataVisualizationScreen extends StatefulWidget {
  final Device device;

  DataVisualizationScreen({required this.device});

  @override
  _DataVisualizationScreenState createState() =>
      _DataVisualizationScreenState();
}

class _DataVisualizationScreenState extends State<DataVisualizationScreen> {
  late List<ChartData> heartRateData;
  late List<ChartData> spo2Data;
  late List<ChartData> temperatureData;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    heartRateData = [];
    spo2Data = [];
    temperatureData = [];
    _startDataUpdate();
  }

  void _startDataUpdate() {
    // Simulating live data update every 5 seconds
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        // Simulate random data for each metric
        heartRateData.add(ChartData(_counter.toDouble(), 60 + _counter % 40));
        spo2Data.add(ChartData(_counter.toDouble(), 95 + _counter % 5));
        temperatureData
            .add(ChartData(_counter.toDouble(), 36.5 + _counter % 2));

        _counter++;
        if (heartRateData.length > 20) heartRateData.removeAt(0);
        if (spo2Data.length > 20) spo2Data.removeAt(0);
        if (temperatureData.length > 20) temperatureData.removeAt(0);
      });
      _startDataUpdate(); // Keep updating
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Data Visualization for ${widget.device.name}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heart Rate Card
            _buildDataCard(
                'Heart Rate',
                heartRateData.isEmpty
                    ? 'N/A'
                    : heartRateData.last.y.toStringAsFixed(2) + ' BPM'),
            SizedBox(height: 16),

            // SpO2 Card
            _buildDataCard(
                'SpO2',
                spo2Data.isEmpty
                    ? 'N/A'
                    : spo2Data.last.y.toStringAsFixed(2) + ' %'),
            SizedBox(height: 16),

            // Temperature Card
            _buildDataCard(
                'Temperature',
                temperatureData.isEmpty
                    ? 'N/A'
                    : temperatureData.last.y.toStringAsFixed(2) + ' °C'),
            SizedBox(height: 16),

            // Chart displaying Heart Rate over Time
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(),
                title: ChartTitle(
                    text: 'Statistics',
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                legend: Legend(isVisible: true),
                series: <LineSeries<ChartData, double>>[
                  LineSeries<ChartData, double>(
                    name: 'Heart Rate',
                    dataSource: heartRateData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.blue,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                  LineSeries<ChartData, double>(
                    name: 'SpO2',
                    dataSource: spo2Data,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.green,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                  LineSeries<ChartData, double>(
                    name: 'Temperature',
                    dataSource: temperatureData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.red,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Latest Value: $subtitle',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final double x; // Represents time or data index
  final double
      y; // Represents sensor value (e.g., heart rate, SpO2, temperature)

  ChartData(this.x, this.y);
}
