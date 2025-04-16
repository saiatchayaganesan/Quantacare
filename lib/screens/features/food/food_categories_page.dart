// lib/screens/features/food/food_categories_page.dart
import 'package:flutter/material.dart';
import 'package:qc/models/food_model.dart';
import 'package:qc/screens/features/food/recipe_list_page.dart';

class FoodCategoriesPage extends StatelessWidget {
  const FoodCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Guide'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch<void>(
                context: context,
                delegate: FoodSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNutritionGoalsSection(),
          const SizedBox(height: 24),
          _buildMealCategoriesSection(context),
          const SizedBox(height: 24),
          _buildDietaryRestrictionsSection(),
        ],
      ),
    );
  }

  Widget _buildNutritionGoalsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Nutrition Goals',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: NutritionGoal.values.map((goal) {
              return Card(
                margin: const EdgeInsets.only(right: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(Icons.track_changes),
                      const SizedBox(height: 8),
                      Text(goal.toString().split('.').last),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMealCategoriesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Meal Categories',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...mealCategories.map((category) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: Icon(category.icon),
              title: Text(category.name),
              subtitle: Text(category.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => RecipeListPage(category: category),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDietaryRestrictionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dietary Restrictions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: DietaryRestriction.values.map((restriction) {
            return FilterChip(
              label: Text(restriction.toString().split('.').last),
              onSelected: (selected) {
                // Handle filter selection
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Add the search delegate
class FoodSearchDelegate extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return ListView.builder(
      itemCount: 0, // Replace with actual search results
      itemBuilder: (context, index) {
        return const ListTile();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions
    return ListView.builder(
      itemCount: 0, // Replace with actual suggestions
      itemBuilder: (context, index) {
        return const ListTile();
      },
    );
  }
}