import 'package:flutter/material.dart';

// Game Over screen that displays the player's final score and
// options to restart or return to main menu
class GameOverView extends StatelessWidget {
  final int finalPoints;
  static const routeName = '/gameover';

  GameOverView({required this.finalPoints});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,),
            ),
            const SizedBox(height: 20),
            Text(
              'Final Points: $finalPoints',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 30),
            ElevatedButton(

              onPressed: () {
                Navigator.popAndPushNamed(context, '/homepage'); // Go back to the game screen
              },
              child: const Text(
                'Return to Home',
                style: TextStyle(fontWeight: FontWeight.bold,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}