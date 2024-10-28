import 'package:flutter/material.dart';

class GameActions {
  static void showPauseMenu(
      BuildContext context, {
        required VoidCallback onResume,
        required VoidCallback onRestart,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pause Menu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: onResume, child: const Text('Resume')),
              ElevatedButton(onPressed: onRestart, child: const Text('Restart')),
              ElevatedButton(
                onPressed: () => Navigator.popAndPushNamed(context, '/homepage'),
                child: const Text('Main Menu'),
              ),
            ],
          ),
        );
      },
    );
  }
}
