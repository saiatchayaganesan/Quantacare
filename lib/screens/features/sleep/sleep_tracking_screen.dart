import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SleepTrackingScreen extends StatefulWidget {
  const SleepTrackingScreen({super.key});

  @override
  State<SleepTrackingScreen> createState() => _SleepTrackingScreenState();
}

class _SleepTrackingScreenState extends State<SleepTrackingScreen> {
  double _sleepDuration = 7.0;
  List<Map<String, dynamic>> _sleepLogs = [];

  @override
  void initState() {
    super.initState();
    _loadSleepData();
  }

  Future<void> _loadSleepData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sleepLogs = (prefs.getStringList('sleep_logs') ?? [])
          .map((e) => jsonDecode(e) as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _saveSleepData() async {
    final prefs = await SharedPreferences.getInstance();
    final newLog = {
      'duration': _sleepDuration,
      'date': DateTime.now().toIso8601String(),
    };
    setState(() {
      _sleepLogs.add(newLog);
    });
    await prefs.setStringList(
      'sleep_logs',
      _sleepLogs.map((e) => jsonEncode(e)).toList(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged ${_sleepDuration.toStringAsFixed(1)} hours of sleep')),
    );
  }

  Future<void> _deleteSleepData(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sleepLogs.removeAt(index);
    });
    await prefs.setStringList(
      'sleep_logs',
      _sleepLogs.map((e) => jsonEncode(e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Log Your Sleep',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Sleep Duration: ${_sleepDuration.toStringAsFixed(1)} hours',
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              value: _sleepDuration,
              min: 0,
              max: 12,
              divisions: 24,
              label: _sleepDuration.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _sleepDuration = value;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveSleepData,
              child: const Text('Log Sleep'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Sleep Log:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _sleepLogs.length,
                itemBuilder: (context, index) {
                  final log = _sleepLogs[index];
                  final formattedDate = DateTime.parse(log['date']).toLocal().toString().split(' ')[0];
                  return ListTile(
                    title: Text('${log['duration']} hours'),
                    subtitle: Text('Date: $formattedDate'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteSleepData(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}