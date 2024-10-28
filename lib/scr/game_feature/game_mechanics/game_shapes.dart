import 'package:flutter/material.dart';

class GameShapes {
  static Widget buildGameBody(
      BuildContext context,
      int points,
      Map<String, List<String>> shuffledFoodArrays,
      bool isGamePaused, {
        required Function(String, String) onTargetAccept,
      }) {
    return Column(
      children: [
        Text('Points: $points'),

        Row(
          children: shuffledFoodArrays.values.expand((list) {
            return list.map((item) {
              return _buildDraggable(context, item, isGamePaused);
            }).toList();
          }).toList(),
        ),

        Row(
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
    return Container(
      width: 50,
      height: 50,
      color: isFeedback ? Colors.grey : Colors.blue,
      child: Center(child: Text(item, style: const TextStyle(color: Colors.white))),
    );
  }

  static Widget _buildTarget(BuildContext context, String category, {required void Function(String) onAccept}) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(width: 80, height: 80, color: Colors.green, child: Center(child: Text(category)));
      },
      onAccept: onAccept,
    );
  }
}
