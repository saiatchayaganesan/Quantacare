import 'package:flutter/material.dart';

class ExerciseRecommendations {
  final Duration duration;
  final int sets;
  final int reps;
  final String? restBetweenSets;
  final String? tempo;
  final String? breathingPattern;
  final List<String>? formCues;
  final Map<String, String>? modifications;

  ExerciseRecommendations({
    required this.duration,
    required this.sets,
    required this.reps,
    this.restBetweenSets,
    this.tempo,
    this.breathingPattern,
    this.formCues,
    this.modifications,
  });

  Map<String, dynamic> toMap() {
    return {
      'duration': duration.inSeconds,
      'sets': sets,
      'reps': reps,
      if (restBetweenSets != null) 'restBetweenSets': restBetweenSets,
      if (tempo != null) 'tempo': tempo,
      if (breathingPattern != null) 'breathingPattern': breathingPattern,
      if (formCues != null) 'formCues': formCues,
      if (modifications != null) 'modifications': modifications,
    };
  }
}

class ExerciseCategory {
  final String id;
  final String name;
  final IconData icon;
  final String description;
  final List<Exercise> exercises;

  ExerciseCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'description': description,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }
}

class Exercise {
  final String id;
  final String name;
  final String type;
  final String duration;
  final String intensity;
  final String benefits;
  final String description;
  final String imageUrl;
  final List<String> steps;
  final List<String> tips;
  final ExerciseDifficulty difficulty;
  final ExerciseRecommendations recommendations;
  final List<String> targetMuscles;
  final List<String> equipment;
  final List<String> variations;

  Exercise({
    required this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.intensity,
    required this.benefits,
    required this.description,
    required this.imageUrl,
    required this.steps,
    required this.tips,
    required this.difficulty,
    required this.recommendations,
    required this.targetMuscles,
    required this.equipment,
    required this.variations,
  });

  Duration get recommendedDuration => recommendations.duration;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'duration': duration,
      'intensity': intensity,
      'benefits': benefits,
      'description': description,
      'imageUrl': imageUrl,
      'steps': steps,
      'tips': tips,
      'difficulty': difficulty.toString(),
      'recommendations': recommendations.toMap(),
      'targetMuscles': targetMuscles,
      'equipment': equipment,
      'variations': variations,
    };
  }

  static Exercise fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      duration: map['duration'],
      intensity: map['intensity'],
      benefits: map['benefits'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      steps: List<String>.from(map['steps']),
      tips: List<String>.from(map['tips']),
      difficulty: ExerciseDifficulty.values.firstWhere(
            (e) => e.toString() == map['difficulty'],
      ),
      recommendations: ExerciseRecommendations(
        duration: Duration(seconds: map['recommendations']['duration']),
        sets: map['recommendations']['sets'],
        reps: map['recommendations']['reps'],
        restBetweenSets: map['recommendations']['restBetweenSets'],
        tempo: map['recommendations']['tempo'],
        breathingPattern: map['recommendations']['breathingPattern'],
        formCues: List<String>.from(map['recommendations']['formCues'] ?? []),
        modifications: Map<String, String>.from(
            map['recommendations']['modifications'] ?? {}),
      ),
      targetMuscles: List<String>.from(map['targetMuscles']),
      equipment: List<String>.from(map['equipment']),
      variations: List<String>.from(map['variations']),
    );
  }
}

enum ExerciseDifficulty { beginner, intermediate, advanced }

// Define a single category containing all exercises
final List<ExerciseCategory> exerciseCategories = [
  ExerciseCategory(
    id: 'all_exercises',
    name: 'Exercises for Pre-Diabetics',
    icon: Icons.fitness_center,
    description:
    'A collection of exercises tailored for pre-diabetic individuals.',
    exercises: [
      Exercise(
        id: 'brisk_walking',
        name: 'Brisk Walking',
        type: 'Aerobic',
        duration: '30 minutes',
        intensity: 'Moderate',
        benefits:
        'Improves insulin sensitivity, burns calories, and boosts cardiovascular health.',
        description:
        'A low-impact aerobic exercise suitable for all fitness levels.',
        imageUrl: 'assets/images/walking.jpg', // Add your image path
        steps: [
          'Start with a warm-up of 5 minutes at a slow pace.',
          'Increase your pace to a brisk walk.',
          'Maintain a steady pace for 30 minutes.',
          'Cool down with 5 minutes of slow walking.',
        ],
        tips: [
          'Keep your posture upright.',
          'Swing your arms naturally.',
          'Wear comfortable shoes.',
        ],
        difficulty: ExerciseDifficulty.beginner,
        recommendations: ExerciseRecommendations(
          duration: Duration(minutes: 30),
          sets: 1,
          reps: 1,
          restBetweenSets: 'None',
          tempo: 'Moderate pace',
          breathingPattern: 'Breathe naturally.',
          formCues: [
            'Heel-to-toe walking motion.',
            'Engage your core.',
          ],
          modifications: {
            'easier': 'Walk at a slower pace.',
            'harder': 'Increase speed or add incline.',
          },
        ),
        targetMuscles: ['Legs', 'Core'],
        equipment: ['None'],
        variations: ['Power Walking', 'Treadmill Walking'],
      ),
      Exercise(
        id: 'cycling',
        name: 'Cycling',
        type: 'Aerobic',
        duration: '30 minutes',
        intensity: 'Moderate',
        benefits:
        'Low-impact exercise that improves blood sugar control and leg strength.',
        description:
        'A great cardiovascular workout that is easy on the joints.',
        imageUrl: 'assets/images/cycling.jpg', // Add your image path
        steps: [
          'Adjust the bike seat to the correct height.',
          'Start pedaling at a moderate pace.',
          'Maintain a steady rhythm for 30 minutes.',
          'Cool down by slowing your pace for the last 5 minutes.',
        ],
        tips: [
          'Keep your back straight.',
          'Use proper cycling shoes if possible.',
          'Stay hydrated.',
        ],
        difficulty: ExerciseDifficulty.beginner,
        recommendations: ExerciseRecommendations(
          duration: Duration(minutes: 30),
          sets: 1,
          reps: 1,
          restBetweenSets: 'None',
          tempo: 'Moderate pace',
          breathingPattern: 'Breathe naturally.',
          formCues: [
            'Pedal in smooth circles.',
            'Engage your core.',
          ],
          modifications: {
            'easier': 'Reduce resistance or time.',
            'harder': 'Increase resistance or speed.',
          },
        ),
        targetMuscles: ['Legs', 'Glutes'],
        equipment: ['Bicycle'],
        variations: ['Indoor Cycling', 'Outdoor Cycling'],
      ),
      Exercise(
        id: 'swimming',
        name: 'Swimming',
        type: 'Aerobic',
        duration: '30 minutes',
        intensity: 'Moderate',
        benefits:
        'Full-body workout that is easy on the joints and improves cardiovascular health.',
        description:
        'A low-impact exercise that works all major muscle groups.',
        imageUrl: 'assets/images/swimming.jpg', // Add your image path
        steps: [
          'Start with a warm-up of 5 minutes of slow swimming.',
          'Swim at a moderate pace for 30 minutes.',
          'Cool down with 5 minutes of slow swimming.',
        ],
        tips: [
          'Use proper swimming techniques.',
          'Stay hydrated.',
          'Wear a swim cap and goggles.',
        ],
        difficulty: ExerciseDifficulty.intermediate,
        recommendations: ExerciseRecommendations(
          duration: Duration(minutes: 30),
          sets: 1,
          reps: 1,
          restBetweenSets: 'None',
          tempo: 'Moderate pace',
          breathingPattern: 'Breathe rhythmically.',
          formCues: [
            'Keep your body horizontal.',
            'Use long, smooth strokes.',
          ],
          modifications: {
            'easier': 'Use a kickboard or swim aids.',
            'harder': 'Increase speed or distance.',
          },
        ),
        targetMuscles: ['Full Body'],
        equipment: ['Swimsuit', 'Goggles'],
        variations: ['Freestyle', 'Breaststroke', 'Backstroke'],
      ),
      Exercise(
        id: 'yoga',
        name: 'Yoga',
        type: 'Flexibility',
        duration: '30 minutes',
        intensity: 'Low',
        benefits:
        'Reduces stress, improves flexibility, and helps with blood sugar management.',
        description:
        'A mind-body practice that combines physical postures, breathing, and meditation.',
        imageUrl: 'assets/images/yoga.jpg', // Add your image path
        steps: [
          'Start with a warm-up of 5 minutes of gentle stretching.',
          'Perform a series of yoga poses for 30 minutes.',
          'End with 5 minutes of relaxation and deep breathing.',
        ],
        tips: [
          'Focus on your breath.',
          'Listen to your body and avoid overstretching.',
          'Use a yoga mat for comfort.',
        ],
        difficulty: ExerciseDifficulty.beginner,
        recommendations: ExerciseRecommendations(
          duration: Duration(minutes: 30),
          sets: 1,
          reps: 1,
          restBetweenSets: 'None',
          tempo: 'Slow and controlled',
          breathingPattern: 'Inhale and exhale deeply.',
          formCues: [
            'Maintain proper alignment.',
            'Engage your core.',
          ],
          modifications: {
            'easier': 'Use props like blocks or straps.',
            'harder': 'Hold poses longer or try advanced variations.',
          },
        ),
        targetMuscles: ['Full Body'],
        equipment: ['Yoga Mat'],
        variations: ['Hatha Yoga', 'Vinyasa Yoga', 'Restorative Yoga'],
      ),
      Exercise(
        id: 'bodyweight_squats',
        name: 'Bodyweight Squats',
        type: 'Strength',
        duration: '3 sets of 15',
        intensity: 'Moderate',
        benefits: 'Builds leg strength and improves glucose metabolism.',
        description:
        'A fundamental lower body exercise targeting multiple muscle groups.',
        imageUrl: 'assets/images/squats.jpg', // Add your image path
        steps: [
          'Stand with feet shoulder-width apart.',
          'Keep your chest up and core engaged.',
          'Lower your body as if sitting back into a chair.',
          'Keep knees in line with toes.',
          'Return to starting position.',
        ],
        tips: [
          'Keep your weight in your heels.',
          'Don\'t let your knees cave inward.',
          'Maintain a neutral spine throughout the movement.',
        ],
        difficulty: ExerciseDifficulty.beginner,
        recommendations: ExerciseRecommendations(
          duration: Duration(minutes: 10),
          sets: 3,
          reps: 15,
          restBetweenSets: '60 seconds',
          tempo: '2-1-2',
          breathingPattern: 'Inhale on the way down, exhale on the way up.',
          formCues: [
            'Knees tracking over toes.',
            'Chest proud and upright.',
          ],
          modifications: {
            'easier': 'Use a chair for support.',
            'harder': 'Add jump or weights.',
          },
        ),
        targetMuscles: ['Quadriceps', 'Hamstrings', 'Glutes', 'Core'],
        equipment: ['None'],
        variations: ['Jump Squats', 'Sumo Squats', 'Single-Leg Squats'],
      ),
    ],
  ),
];
