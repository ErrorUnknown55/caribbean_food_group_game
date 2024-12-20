import 'dart:math';

class FoodCategories {
  static const foodArrays = {
    'Staples': ['Bread', 'Corn', 'Cornmeal', 'Flour', 'Pasta', 'Rice','Porridge', 'Green fig', 'Plantain', 'Breadfruit', 'Dasheen', 'Cassava', 'Potato', 'Sweet potato'],
    'Vegetables': ['Carrot', 'Patchoi', 'Callaloo', 'Lettuce', 'Pumpkin', 'Green Pepper', 'Eggplant', 'String beans', 'Cauliflower', 'Broccoli', 'Christophene', 'Cucumber', 'Tomato'],
    'Fruits': ['Oranges', 'Grapefruit', 'Portugal', 'Watermelon', 'Pommecythere', 'Tamarind', 'Guava', 'Pommerac', 'West Indian Cherry', 'Soursop', 'Lime', 'Papaw', 'Banana'],
    'Legumes': ['Red beans', 'Lentils', 'Pigeon Pies', 'Black-eyed peas', 'Channa', 'Peanuts', 'Almonds', 'Cashew nut', 'Sesame seeds', 'Pumpkin Seeds', 'Flax/linsed'],
    'Food from Animals': [ 'Chicken', 'Fish', 'Milk', 'Cheese', 'Yogurt', 'Eggs', 'Liver', 'Beef', 'Ox-tail'],
    'Fat and Oils': ['Cooking oil', 'Avocado', 'Olives', 'Butter', 'Margarine', 'Ghee', 'Coconut milk', 'Ackee'],
  };

  static Map<String, List<String>> getShuffledCategories() {
    final random = Random();

    // Shuffle categories
    final shuffledCategories = foodArrays.keys.toList()..shuffle(random);

    final shuffled = <String, List<String>>{};

    // For each shuffled category, shuffle the list of items within it and store the first 5
    for (var category in shuffledCategories) {
      final list = List<String>.from(foodArrays[category]!);
      list.shuffle(random);
      shuffled[category] = list.take(5).toList();
    }

    return shuffled;
  }
}
