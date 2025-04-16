import 'package:flutter/material.dart';
import 'package:qc/models/exercise_model.dart'; // Import your exercise model
import 'package:qc/screens/features/exercise/exercise_detail_page.dart'; // Import the exercise detail page

class ExerciseCategoriesPage extends StatelessWidget {
  const ExerciseCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Flatten the list of exercises from all categories
    final allExercises =
    exerciseCategories.expand((category) => category.exercises).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises for Pre-Diabetics'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns in the grid
            crossAxisSpacing: 16, // Spacing between columns
            mainAxisSpacing: 16, // Spacing between rows
            childAspectRatio: 1, // Square cards
          ),
          itemCount: allExercises.length, // Number of exercises
          itemBuilder: (context, index) {
            final exercise = allExercises[index]; // Get the exercise
            return _buildExerciseCard(context, exercise); // Build the card
          },
        ),
      ),
    );
  }

  // Helper method to build an exercise card
  Widget _buildExerciseCard(BuildContext context, Exercise exercise) {
    return GestureDetector(
      onTap: () {
        // Navigate to the exercise detail page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetailPage(exercise: exercise),
          ),
        );
      },
      child: Card(
        elevation: 4, // Add shadow to the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue[300]!, Colors.blue[600]!], // Gradient colors
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center, // Use a default icon for exercises
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 8), // Spacing
              Text(
                exercise.name, // Exercise name
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 2, // Limit to 2 lines
                overflow:
                TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
              const SizedBox(height: 4), // Spacing
              Text(
                exercise.type, // Exercise type (e.g., Aerobic, Strength)
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
                maxLines: 1, // Limit to 1 line
                overflow:
                TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
            ],
          ),
        ),
      ),
    );
  }
}
