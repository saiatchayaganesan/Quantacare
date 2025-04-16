import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SensorDataScreen extends StatefulWidget {
  const SensorDataScreen({super.key});

  @override
  SensorDataScreenState createState() => SensorDataScreenState();
}

class SensorDataScreenState extends State<SensorDataScreen> {
  Map<String, dynamic> _sensorData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSensorData();
  }

  Future<void> _fetchSensorData() async {
    final response = await http.get(Uri.parse('https://esskay-012024.live/firebase/fetch_data.php'));

    if (response.statusCode == 200) {
      setState(() {
        _sensorData = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load data');
    }
  }

  Future<void> _saveAsPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Sensor Data Report", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              _buildPdfRow("Humidity", _sensorData['humidity']?.toString() ?? 'N/A', "%"),
              _buildPdfRow("Temperature", _sensorData['temperature']?.toString() ?? 'N/A', "°C"),
              _buildPdfRow("SpO2", _sensorData['spo2']?.toString() ?? 'N/A', "%"),
              _buildPdfRow("Last Updated", _sensorData['reading_time']?.toString() ?? 'N/A', ""),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/sensor_data.pdf");
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF saved at ${file.path}')),
    );
  }

  pw.Widget _buildPdfRow(String label, String value, String unit) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Text("$label: $value $unit", style: pw.TextStyle(fontSize: 18)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Data'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            if (_isLoading) const LinearProgressIndicator(),
            const SizedBox(height: 16),
            _buildMetricCard("Humidity", _sensorData['humidity']?.toString() ?? 'N/A', "%", Colors.blue, Icons.water_drop),
            _buildMetricCard("Temperature", _sensorData['temperature']?.toString() ?? 'N/A', "°C", Colors.red, Icons.thermostat),
            _buildMetricCard("SpO2", _sensorData['spo2']?.toString() ?? 'N/A', "%", Colors.green, Icons.air),
            _buildMetricCard("Last Updated", _sensorData['reading_time']?.toString() ?? 'N/A', "", Colors.purple, Icons.access_time),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _fetchSensorData,
              icon: const Icon(Icons.refresh),
              label: const Text('REFRESH DATA'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _saveAsPdf,
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('SAVE AS PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String unit, Color color, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Text('$value $unit', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
