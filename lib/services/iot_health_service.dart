import 'package:logger/logger.dart';
import 'package:qc/models/health_report_model.dart';

class IoTHealthService {
  final Logger _logger = Logger();
  final List<HealthMeasurement> _measurements =
  []; // List to store measurements

  Future<void> saveMeasurement({
    required int bloodPressureSystolic,
    required int bloodPressureDiastolic,
    required int heartRate,
    required double bloodSugar,
    required double hbA1c,
    required int spo2,
    required double bodyFatPercentage,
    required int steps,
    required String deviceId,
    required String notes,
  }) async {
    // Create a new HealthMeasurement object
    final HealthMeasurement newMeasurement = HealthMeasurement(
      timestamp: DateTime.now(),
      bloodPressureSystolic: bloodPressureSystolic,
      bloodPressureDiastolic: bloodPressureDiastolic,
      heartRate: heartRate,
      bloodSugar: bloodSugar,
      hbA1c: hbA1c,
      spo2: spo2,
      bodyFatPercentage: bodyFatPercentage,
      steps: steps,
      deviceId: deviceId,
      notes: notes,
    );

    // Add the new measurement to the list
    _measurements.add(newMeasurement);

    // Log the saved measurement
    _logger.i('Measurement saved:');
    _logger.i(
        'Blood Pressure: $bloodPressureSystolic/$bloodPressureDiastolic mmHg');
    _logger.i('Heart Rate: $heartRate bpm');
    _logger.i('Blood Sugar: $bloodSugar mg/dL');
    _logger.i('HbA1c: $hbA1c %');
    _logger.i('SpO2: $spo2 %');
    _logger.i('Body Fat Percentage: $bodyFatPercentage %');
    _logger.i('Steps: $steps');
    _logger.i('Device ID: $deviceId');
    _logger.i('Notes: $notes');
  }

  Future<HealthReport> getReport() async {
    // Return the stored measurements
    return HealthReport(measurements: _measurements);
  }
}

