import 'package:flutter/material.dart';

enum MealType { breakfast, lunch, dinner, snack }

enum DietaryRestriction {
  vegetarian,
  vegan,
  glutenFree,
  dairyFree,
  nutFree,
  none
}

enum NutritionGoal { weightLoss, maintenance, muscleGain, healthy }

class NutritionalInfo {
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final double? fiber;
  final double? sugar;
  final Map<String, double>? vitamins;

  NutritionalInfo({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.fiber,
    this.sugar,
    this.vitamins,
  });

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      if (fiber != null) 'fiber': fiber,
      if (sugar != null) 'sugar': sugar,
      if (vitamins != null) 'vitamins': vitamins,
    };
  }
}

class Recipe {
  final String id;
  final String name;
  final String description;
  final List<MealType> suitableFor;
  final List<DietaryRestriction> dietaryRestrictions;
  final NutritionalInfo nutritionalInfo;
  final Duration prepTime;
  final Duration cookTime;
  final List<String> ingredients;
  final List<String> instructions;
  final List<String> tips;
  final String iconSvg;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.suitableFor,
    required this.dietaryRestrictions,
    required this.nutritionalInfo,
    required this.prepTime,
    required this.cookTime,
    required this.ingredients,
    required this.instructions,
    required this.tips,
    required this.iconSvg,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'suitableFor': suitableFor.map((e) => e.toString()).toList(),
      'dietaryRestrictions':
      dietaryRestrictions.map((e) => e.toString()).toList(),
      'nutritionalInfo': nutritionalInfo.toMap(),
      'prepTime': prepTime.inMinutes,
      'cookTime': cookTime.inMinutes,
      'ingredients': ingredients,
      'instructions': instructions,
      'tips': tips,
      'iconSvg': iconSvg,
    };
  }
}

class MealCategory {
  final String id;
  final String name;
  final IconData icon;
  final String description;
  final List<Recipe> recipes;

  MealCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.recipes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'description': description,
      'recipes': recipes.map((e) => e.toMap()).toList(),
    };
  }
}

// Sample data
final List<MealCategory> mealCategories = [
  MealCategory(
    id: 'healthy_breakfast',
    name: 'Healthy Breakfast',
    icon: Icons.breakfast_dining,
    description: 'Start your day with nutritious breakfast options',
    recipes: [
      Recipe(
        id: 'oatmeal_bowl',
        name: 'Protein Oatmeal Bowl',
        description:
        'A hearty bowl of oatmeal packed with protein and nutrients',
        suitableFor: [MealType.breakfast],
        dietaryRestrictions: [DietaryRestriction.vegetarian],
        nutritionalInfo: NutritionalInfo(
          calories: 350,
          protein: 15,
          carbs: 45,
          fat: 12,
          fiber: 8,
          sugar: 5,
        ),
        prepTime: Duration(minutes: 5),
        cookTime: Duration(minutes: 10),
        ingredients: [
          '1 cup rolled oats',
          '1 scoop protein powder',
          '1 banana',
          '1 tbsp honey',
          '1 cup almond milk',
          'Handful of berries',
        ],
        instructions: [
          'Bring almond milk to a boil',
          'Add oats and reduce heat',
          'Cook for 5 minutes, stirring occasionally',
          'Add protein powder and stir well',
          'Top with sliced banana, berries, and honey',
        ],
        tips: [
          'Use steel-cut oats for better texture',
          'Add chia seeds for extra nutrients',
          'Prepare overnight for quicker morning',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <circle cx="50" cy="50" r="40" fill="#f5d6a7"/>
            <circle cx="50" cy="50" r="30" fill="#e6b980"/>
            <circle cx="30" cy="40" r="8" fill="#ff6b6b"/>
            <circle cx="60" cy="35" r="8" fill="#4ecdc4"/>
          </svg>
        ''',
      ),
      Recipe(
        id: 'avocado_toast',
        name: 'Avocado Toast',
        description:
        'A simple yet delicious avocado toast with a sprinkle of seeds',
        suitableFor: [MealType.breakfast],
        dietaryRestrictions: [DietaryRestriction.vegan],
        nutritionalInfo: NutritionalInfo(
          calories: 300,
          protein: 8,
          carbs: 25,
          fat: 20,
          fiber: 10,
          sugar: 2,
        ),
        prepTime: Duration(minutes: 5),
        cookTime: Duration(minutes: 5),
        ingredients: [
          '1 ripe avocado',
          '2 slices whole-grain bread',
          '1 tbsp olive oil',
          '1 tsp chia seeds',
          '1 tsp sesame seeds',
          'Salt and pepper to taste',
        ],
        instructions: [
          'Toast the bread slices until golden brown',
          'Mash the avocado in a bowl and mix with olive oil',
          'Spread the avocado mixture on the toast',
          'Sprinkle chia seeds, sesame seeds, salt, and pepper',
        ],
        tips: [
          'Add a poached egg for extra protein',
          'Use sourdough bread for a tangy flavor',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <rect x="10" y="10" width="80" height="80" fill="#8bc34a"/>
            <circle cx="50" cy="50" r="30" fill="#4caf50"/>
          </svg>
        ''',
      ),
      Recipe(
        id: 'smoothie_bowl',
        name: 'Smoothie Bowl',
        description: 'A refreshing smoothie bowl topped with fruits and nuts',
        suitableFor: [MealType.breakfast],
        dietaryRestrictions: [DietaryRestriction.vegan],
        nutritionalInfo: NutritionalInfo(
          calories: 280,
          protein: 10,
          carbs: 40,
          fat: 8,
          fiber: 6,
          sugar: 20,
        ),
        prepTime: Duration(minutes: 10),
        cookTime: Duration(minutes: 0),
        ingredients: [
          '1 frozen banana',
          '1/2 cup frozen berries',
          '1/2 cup almond milk',
          '1 tbsp chia seeds',
          '1/4 cup granola',
          '1 tbsp almond butter',
        ],
        instructions: [
          'Blend frozen banana, berries, and almond milk until smooth',
          'Pour the smoothie into a bowl',
          'Top with chia seeds, granola, and almond butter',
        ],
        tips: [
          'Add a handful of spinach for extra nutrients',
          'Use coconut milk for a tropical twist',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <circle cx="50" cy="50" r="40" fill="#b2dfdb"/>
            <circle cx="50" cy="50" r="30" fill="#80cbc4"/>
          </svg>
        ''',
      ),
      Recipe(
        id: 'egg_muffins',
        name: 'Egg Muffins',
        description: 'Protein-packed egg muffins with vegetables',
        suitableFor: [MealType.breakfast],
        dietaryRestrictions: [DietaryRestriction.none],
        nutritionalInfo: NutritionalInfo(
          calories: 200,
          protein: 12,
          carbs: 8,
          fat: 14,
          fiber: 2,
          sugar: 2,
        ),
        prepTime: Duration(minutes: 10),
        cookTime: Duration(minutes: 20),
        ingredients: [
          '4 eggs',
          '1/2 cup spinach',
          '1/4 cup diced bell peppers',
          '1/4 cup shredded cheese',
          'Salt and pepper to taste',
        ],
        instructions: [
          'Preheat the oven to 375°F (190°C)',
          'Whisk the eggs in a bowl',
          'Add spinach, bell peppers, cheese, salt, and pepper',
          'Pour the mixture into a muffin tin',
          'Bake for 20 minutes or until set',
        ],
        tips: [
          'Add cooked bacon or sausage for extra flavor',
          'Store in the fridge for a quick breakfast',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <rect x="10" y="10" width="80" height="80" fill="#ffcc80"/>
            <circle cx="50" cy="50" r="30" fill="#ffa726"/>
          </svg>
        ''',
      ),
      Recipe(
        id: 'chia_pudding',
        name: 'Chia Pudding',
        description: 'A creamy and nutritious chia pudding',
        suitableFor: [MealType.breakfast],
        dietaryRestrictions: [DietaryRestriction.vegan],
        nutritionalInfo: NutritionalInfo(
          calories: 250,
          protein: 8,
          carbs: 30,
          fat: 10,
          fiber: 12,
          sugar: 10,
        ),
        prepTime: Duration(minutes: 5),
        cookTime: Duration(minutes: 0),
        ingredients: [
          '1/4 cup chia seeds',
          '1 cup almond milk',
          '1 tbsp maple syrup',
          '1/2 tsp vanilla extract',
          'Fresh berries for topping',
        ],
        instructions: [
          'Mix chia seeds, almond milk, maple syrup, and vanilla extract in a jar',
          'Stir well and let it sit for 5 minutes',
          'Refrigerate overnight',
          'Top with fresh berries before serving',
        ],
        tips: [
          'Add cocoa powder for a chocolate version',
          'Use coconut milk for a richer texture',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <circle cx="50" cy="50" r="40" fill="#d1c4e9"/>
            <circle cx="50" cy="50" r="30" fill="#b39ddb"/>
          </svg>
        ''',
      ),
    ],
  ),
  MealCategory(
    id: 'healthy_lunch',
    name: 'Healthy Lunch',
    icon: Icons.lunch_dining,
    description: 'Nutritious and balanced lunch options',
    recipes: [
      Recipe(
        id: 'quinoa_salad',
        name: 'Quinoa Salad',
        description:
        'A refreshing quinoa salad with vegetables and feta cheese',
        suitableFor: [MealType.lunch],
        dietaryRestrictions: [DietaryRestriction.vegetarian],
        nutritionalInfo: NutritionalInfo(
          calories: 400,
          protein: 12,
          carbs: 50,
          fat: 15,
          fiber: 8,
          sugar: 6,
        ),
        prepTime: Duration(minutes: 10),
        cookTime: Duration(minutes: 15),
        ingredients: [
          '1 cup quinoa',
          '1 cucumber',
          '1 tomato',
          '1/2 cup feta cheese',
          '2 tbsp olive oil',
          '1 tbsp lemon juice',
          'Salt and pepper to taste',
        ],
        instructions: [
          'Cook quinoa according to package instructions',
          'Chop cucumber and tomato into small pieces',
          'Mix quinoa, cucumber, tomato, and feta cheese in a bowl',
          'Drizzle olive oil and lemon juice, then season with salt and pepper',
        ],
        tips: [
          'Add grilled chicken for extra protein',
          'Use fresh herbs like parsley or mint for added flavor',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <circle cx="50" cy="50" r="40" fill="#ffcc80"/>
            <rect x="20" y="20" width="60" height="60" fill="#ffa726"/>
          </svg>
        ''',
      ),
      Recipe(
        id: 'grilled_chicken_wrap',
        name: 'Grilled Chicken Wrap',
        description: 'A healthy wrap with grilled chicken and fresh veggies',
        suitableFor: [MealType.lunch],
        dietaryRestrictions: [DietaryRestriction.none],
        nutritionalInfo: NutritionalInfo(
          calories: 350,
          protein: 25,
          carbs: 30,
          fat: 12,
          fiber: 5,
          sugar: 4,
        ),
        prepTime: Duration(minutes: 10),
        cookTime: Duration(minutes: 15),
        ingredients: [
          '1 grilled chicken breast',
          '1 whole-grain tortilla',
          '1/2 cup lettuce',
          '1/4 cup diced tomatoes',
          '1/4 cup shredded carrots',
          '2 tbsp Greek yogurt',
          '1 tsp mustard',
        ],
        instructions: [
          'Slice the grilled chicken breast into strips',
          'Spread Greek yogurt and mustard on the tortilla',
          'Layer lettuce, tomatoes, carrots, and chicken on the tortilla',
          'Roll the tortilla tightly and slice in half',
        ],
        tips: [
          'Add avocado for extra creaminess',
          'Use hummus instead of Greek yogurt for a vegan option',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <rect x="10" y="10" width="80" height="80" fill="#ffcc80"/>
            <circle cx="50" cy="50" r="30" fill="#ffa726"/>
          </svg>
        ''',
      ),
      // Add 3 more lunch recipes here...
    ],
  ),
  MealCategory(
    id: 'healthy_dinner',
    name: 'Healthy Dinner',
    icon: Icons.dinner_dining,
    description: 'Light and wholesome dinner options',
    recipes: [
      Recipe(
        id: 'grilled_salmon',
        name: 'Grilled Salmon',
        description: 'Grilled salmon with a side of steamed vegetables',
        suitableFor: [MealType.dinner],
        dietaryRestrictions: [DietaryRestriction.none],
        nutritionalInfo: NutritionalInfo(
          calories: 450,
          protein: 35,
          carbs: 20,
          fat: 25,
          fiber: 5,
          sugar: 3,
        ),
        prepTime: Duration(minutes: 10),
        cookTime: Duration(minutes: 15),
        ingredients: [
          '1 salmon fillet',
          '1 tbsp olive oil',
          '1 tsp garlic powder',
          '1 tsp paprika',
          '1 cup broccoli',
          '1 cup carrots',
          'Salt and pepper to taste',
        ],
        instructions: [
          'Preheat the grill to medium-high heat',
          'Season the salmon with olive oil, garlic powder, paprika, salt, and pepper',
          'Grill the salmon for 5-7 minutes on each side',
          'Steam broccoli and carrots until tender',
          'Serve the salmon with steamed vegetables',
        ],
        tips: [
          'Add a squeeze of lemon for extra flavor',
          'Pair with quinoa or brown rice for a complete meal',
        ],
        iconSvg: '''
          <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <rect x="10" y="10" width="80" height="80" fill="#ff7043"/>
            <circle cx="50" cy="50" r="30" fill="#ff5722"/>
          </svg>
        ''',
      ),
      // Add 4 more dinner recipes here...
    ],
  ),
];
