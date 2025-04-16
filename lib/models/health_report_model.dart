class HealthMeasurement {
  final DateTime timestamp;
  final int bloodPressureSystolic;
  final int bloodPressureDiastolic;
  final int heartRate;
  final double bloodSugar;
  final double hbA1c; // Added hbA1c field
  final int spo2; // Added spo2 field
  final double bodyFatPercentage; // Added bodyFatPercentage field
  final int steps; // Added steps field
  final String deviceId;
  final String? notes;

  HealthMeasurement({
    required this.timestamp,
    required this.bloodPressureSystolic,
    required this.bloodPressureDiastolic,
    required this.heartRate,
    required this.bloodSugar,
    required this.hbA1c, // Added hbA1c parameter
    required this.spo2, // Added spo2 parameter
    required this.bodyFatPercentage, // Added bodyFatPercentage parameter
    required this.steps, // Added steps parameter
    required this.deviceId,
    this.notes,
  });

  // Convert to and from JSON for storage
  Map<String, dynamic> toJson() => {
    'timestamp': timestamp.toIso8601String(),
    'bloodPressureSystolic': bloodPressureSystolic,
    'bloodPressureDiastolic': bloodPressureDiastolic,
    'heartRate': heartRate,
    'bloodSugar': bloodSugar,
    'hbA1c': hbA1c, // Added hbA1c to JSON
    'spo2': spo2, // Added spo2 to JSON
    'bodyFatPercentage':
    bodyFatPercentage, // Added bodyFatPercentage to JSON
    'steps': steps, // Added steps to JSON
    'deviceId': deviceId,
    'notes': notes,
  };

  factory HealthMeasurement.fromJson(Map<String, dynamic> json) {
    return HealthMeasurement(
      timestamp: DateTime.parse(json['timestamp']),
      bloodPressureSystolic: json['bloodPressureSystolic'],
      bloodPressureDiastolic: json['bloodPressureDiastolic'],
      heartRate: json['heartRate'],
      bloodSugar: json['bloodSugar'],
      hbA1c: json['hbA1c'], // Added hbA1c from JSON
      spo2: json['spo2'], // Added spo2 from JSON
      bodyFatPercentage:
      json['bodyFatPercentage'], // Added bodyFatPercentage from JSON
      steps: json['steps'], // Added steps from JSON
      deviceId: json['deviceId'],
      notes: json['notes'],
    );
  }
}

class HealthReport {
  final List<HealthMeasurement> measurements;

  HealthReport({required this.measurements});

  // Get measurements sorted by date (newest first)
  List<HealthMeasurement> get sortedMeasurements {
    final sorted = List<HealthMeasurement>.from(measurements);
    sorted.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted;
  }

  // Group measurements by day
  Map<String, List<HealthMeasurement>> groupByDay() {
    final Map<String, List<HealthMeasurement>> grouped = {};
    for (var measurement in measurements) {
      final dateStr = _formatDate(measurement.timestamp);
      if (!grouped.containsKey(dateStr)) {
        grouped[dateStr] = [];
      }
      grouped[dateStr]!.add(measurement);
    }
    return grouped;
  }

  // Helper method to format date consistently
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // Get average blood pressure over a given period
  Map<String, double> getAverageBloodPressure() {
    if (measurements.isEmpty) return {'systolic': 0, 'diastolic': 0};

    int totalSystolic = 0;
    int totalDiastolic = 0;

    for (var m in measurements) {
      totalSystolic += m.bloodPressureSystolic;
      totalDiastolic += m.bloodPressureDiastolic;
    }

    return {
      'systolic': totalSystolic / measurements.length,
      'diastolic': totalDiastolic / measurements.length,
    };
  }

  // Get average heart rate
  double getAverageHeartRate() {
    if (measurements.isEmpty) return 0;

    int total = 0;
    for (var m in measurements) {
      total += m.heartRate;
    }

    return total / measurements.length;
  }
}
