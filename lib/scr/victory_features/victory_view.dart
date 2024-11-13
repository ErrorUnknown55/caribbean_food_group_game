import 'package:caribbean_food_group_game/util/scr_size.dart';
import 'package:flutter/material.dart';
//Victory screen that displays the player's final score and time taken,
//with options to restart or return to main menu
class VictoryView extends StatelessWidget {
  final int finalPoints;
  final int timeTaken;

  VictoryView({required this.finalPoints, required this.timeTaken});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: ScrSize.getScreenWidth(context) / 4,
            ),
            SizedBox(height: 20.0),
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: ScrSize.getScreenWidth(context)/ 12,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),

            ),
            SizedBox(height: 10.0),
            Text(
              'Time taken: $timeTaken\'s',
              style: TextStyle(
                  fontSize: ScrSize.getScreenWidth(context)/ 25,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'You completed the game with $finalPoints points!',
              style: TextStyle(
                  fontSize: ScrSize.getScreenWidth(context)/ 25,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set button background color
              ),
              onPressed: () {
                // You can navigate to the main menu or perform any other action here
                Navigator.pop(context);
              },
              child: Text('Return to Main Menu'),

            ),
          ],
        ),
      ),
    );
  }
}
