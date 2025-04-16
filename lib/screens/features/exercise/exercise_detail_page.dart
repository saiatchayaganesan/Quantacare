import 'package:flutter/material.dart';
import 'package:qc/models/exercise_model.dart';

class ExerciseDetailPage extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  int _secondsRemaining = 0; // Timer duration in seconds
  bool _isTimerRunning = false;

  void _startTimer(int durationInSeconds) {
    setState(() {
      _secondsRemaining = durationInSeconds; // Set timer duration in seconds
      _isTimerRunning = true;
    });

    // Timer logic
    Future.delayed(const Duration(seconds: 1), () {
      if (_secondsRemaining > 0 && _isTimerRunning) {
        setState(() {
          _secondsRemaining--; // Decrement the timer
        });
        _startTimer(_secondsRemaining); // Continue the timer
      } else {
        setState(() {
          _isTimerRunning = false;
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    final durationInSeconds = exercise
        .recommendedDuration.inSeconds; // Use seconds instead of minutes

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(75),
                ),
                child: Icon(
                  Icons.fitness_center,
                  size: 80,
                  color: Colors.blue[700],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Description:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              exercise.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Steps:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...exercise.steps.map((step) => Text('- $step')).toList(),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'Timer: ${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _isTimerRunning
                            ? null
                            : () => _startTimer(durationInSeconds),
                        child: const Text('Start Timer'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _isTimerRunning ? _stopTimer : null,
                        child: const Text('Stop Timer'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
