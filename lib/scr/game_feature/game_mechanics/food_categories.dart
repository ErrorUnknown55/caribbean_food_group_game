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
    final shuffled = <String, List<String>>{};
    foodArrays.forEach((key, value) {
      final list = List<String>.from(value);
      list.shuffle(random);
      shuffled[key] = list.take(5).toList();
    });
    return shuffled;
  }
}
