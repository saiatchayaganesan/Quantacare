import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc/models/health_report_model.dart';
import 'package:qc/services/iot_health_service.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:qc/screens/features/health_monitoring/sensor_data_screen.dart';
class HealthReportScreen extends StatefulWidget {
  const HealthReportScreen({super.key});

  @override
  State<HealthReportScreen> createState() => _HealthReportScreenState();
}

class _HealthReportScreenState extends State<HealthReportScreen> {
  final IoTHealthService _healthService = IoTHealthService();
  HealthReport? _report;
  bool _isLoading = true;
  String? _pdfFilePath; // Path to the generated PDF file

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    setState(() => _isLoading = true);
    final report = await _healthService.getReport();
    setState(() {
      _report = report;
      _isLoading = false;
    });
  }

  Future<void> _generateAndSavePDF() async {
    if (_report == null || _report!.measurements.isEmpty) return;

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Health Report",
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 16),
              ..._report!.measurements.map((measurement) => pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 4),
                child: pw.Text(
                  "${DateFormat('yyyy-MM-dd HH:mm').format(measurement.timestamp)} - BP: ${measurement.bloodPressureSystolic}/${measurement.bloodPressureDiastolic}, HR: ${measurement.heartRate} bpm, Sugar: ${measurement.bloodSugar} mg/dL",
                  style: pw.TextStyle(fontSize: 14),
                ),
              )),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/Health_Report.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    setState(() {
      _pdfFilePath = filePath;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("PDF Saved: $filePath")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Report'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadReport,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _generateAndSavePDF,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[50]!,
              Colors.purple[50]!,
            ],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _pdfFilePath == null
            ? _buildReportContent()
            : _buildPDFViewer(),
      ),
    );
  }

  Widget _buildPDFViewer() {
    return Column(
      children: [
        Expanded(
          child: PDFView(
            filePath: _pdfFilePath!,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onError: (error) {
              print("Error loading PDF: $error");
            },
            onRender: (pages) {
              setState(() {}); // Refresh after rendering
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _pdfFilePath = null; // Go back to report view
            });
          },
          child: const Text("Back to Report"),
        ),
      ],
    );
  }

  Widget _buildReportContent() {
    if (_report == null || _report!.measurements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No health measurements recorded yet',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Take New Measurement'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SensorDataScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(child: _buildMeasurementList()),
        ElevatedButton.icon(
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text("View Generated PDF"),
          onPressed: () {
            if (_pdfFilePath != null) {
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Widget _buildMeasurementList() {
    final groupedData = _report!.groupByDay();
    final sortedDates = groupedData.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      itemCount: sortedDates.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final dateStr = sortedDates[index];
        final dayMeasurements = groupedData[dateStr]!;
        return _buildDayCard(dateStr, dayMeasurements);
      },
    );
  }

  Widget _buildDayCard(String dateStr, List<HealthMeasurement> measurements) {
    final dateParts = dateStr.split('-').map(int.parse).toList();
    final date = DateTime(dateParts[0], dateParts[1], dateParts[2]);
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          dateFormat.format(date),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${measurements.length} measurements'),
        children: measurements.map((measurement) => _buildMeasurementTile(measurement)).toList(),
      ),
    );
  }

  Widget _buildMeasurementTile(HealthMeasurement measurement) {
    return ListTile(
      title: Text("BP: ${measurement.bloodPressureSystolic}/${measurement.bloodPressureDiastolic}"),
      subtitle: Text("HR: ${measurement.heartRate} bpm"),
    );
  }
}
