import 'package:caribbean_food_group_game/scr/game_feature/game_mechanics/game_timer.dart';
import 'package:flutter/material.dart';

class GameShapes {
  static Widget buildGameBody(BuildContext context,
      int points, Map<String, List<String>> shuffledFoodArrays, bool isGamePaused, {
        required Function(String, String) onTargetAccept,
      }) {

    // Combine all items and limit to 10
    final allItems = shuffledFoodArrays.values.expand((list) => list).take(60).toList();

    return Column(
      children: [
        Text('Points: $points',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),

        /*Text('Points: $',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),*/

        // ListView displaying draggable items
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allItems.length,
            itemBuilder: (context, index) {
              return _buildDraggable(context, allItems[index], isGamePaused);
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: shuffledFoodArrays.keys.map((category) {
            return _buildTarget(context, category, onAccept: (data) => onTargetAccept(category, data));
          }).toList(),
        ),
      ],
    );
  }

  static Widget _buildDraggable(BuildContext context, String item, bool isGamePaused) {
    return Draggable<String>(
      data: item,
      child: _buildShape(context, item, isGamePaused),
      feedback: _buildShape(context, item, isGamePaused, isFeedback: true),
      childWhenDragging: Container(),
    );
  }

  static Widget _buildShape(BuildContext context, String item, bool isGamePaused, {bool isFeedback = false}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: isFeedback ? Colors.black12 : Colors.blue,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              item,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildTarget(BuildContext context, String category, {required void Function(String) onAccept}) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            width: 125,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16,
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
      onAccept: onAccept,
    );
  }
}
