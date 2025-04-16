// lib/screens/features/food/recipe_list_page.dart
import 'package:flutter/material.dart';
import 'package:qc/models/food_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc/screens/features/food/recipe_detail_page.dart';

class RecipeListPage extends StatelessWidget {
  final MealCategory category;

  const RecipeListPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: category.recipes.length,
        itemBuilder: (context, index) {
          final recipe = category.recipes[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailPage(recipe: recipe),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: SvgPicture.string(
                      recipe.iconSvg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: 8),
                        Text(recipe.description),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 16),
                            SizedBox(width: 4),
                            Text(
                                '${recipe.prepTime.inMinutes + recipe.cookTime.inMinutes} mins'),
                            SizedBox(width: 16),
                            Icon(Icons.local_fire_department, size: 16),
                            SizedBox(width: 4),
                            Text('${recipe.nutritionalInfo.calories} cal'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}