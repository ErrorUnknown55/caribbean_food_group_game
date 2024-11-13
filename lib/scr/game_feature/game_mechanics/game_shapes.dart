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
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: isFeedback ? Colors.black12 : Colors.blue,
          borderRadius: BorderRadius.circular(18)
        ),
        child: Center(child: Text(item,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white)
        )),
      ),
    );
  }

  //Displays the different Food Groups for the user to.
  static Widget _buildTarget(BuildContext context, String category, {required void Function(String) onAccept}) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Center(child: Text(category)
              )
          ),
        );
      },
      onAccept: onAccept,
    );
  }
}
