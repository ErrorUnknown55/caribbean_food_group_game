import 'package:caribbean_food_group_game/scr/game_feature/game_mechanics/food_categories.dart';
import 'package:caribbean_food_group_game/scr/game_feature/game_mechanics/game_actions.dart';
import 'package:caribbean_food_group_game/scr/game_feature/game_mechanics/game_shapes.dart';
import 'package:caribbean_food_group_game/scr/game_feature/game_mechanics/game_timer.dart';
import 'package:caribbean_food_group_game/scr/game_over_feature/game_over_view.dart';
import 'package:caribbean_food_group_game/scr/victory_features/victory_view.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);
  static const routeName = '/gameview';

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late TimerController _timerController;
  int _points = 0;
  bool _gameOver = false;
  bool _isGamePaused = false;
  bool _isPauseMenuVisible = false;
  Map<String, List<String>> shuffledFoodArrays = {};

  @override
  void initState() {
    super.initState();
    shuffledFoodArrays = FoodCategories.getShuffledCategories();
    _timerController = TimerController(onGameOver: gameOver);
  }

  void gameOver() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverView(finalPoints: _points),
      ),
    );
  }

  void showCongratsScreen() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VictoryView(finalPoints: _points, timeTaken: 60 - _timeRemaining),
    //   ),
    // );
  }

  void pauseGame() {
    setState(() => _isGamePaused = true);
    _timerController.pauseTimer();
  }

  void resumeGame() {
    setState(() => _isGamePaused = false);
    _timerController.resumeTimer();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: () {
              pauseGame();
              GameActions.showPauseMenu(context, onResume: resumeGame, onRestart: resetGame);
            },
          ),
        ],
      ),

      body: AbsorbPointer(
        absorbing: _isGamePaused,
        child: GameShapes.buildGameBody(
          context,
          _points,
          shuffledFoodArrays,
          _isGamePaused,
          onTargetAccept: onTargetAccept,
        ),
      ),
    );
  }

  void onTargetAccept(String category, String data) {
    setState(() {
      if (shuffledFoodArrays[category]!.contains(data)) {
        _points += 1;
      } else {
        _points -= 1;
      }
      shuffledFoodArrays[category]!.remove(data);
      if (shuffledFoodArrays.values.every((list) => list.isEmpty)) {
        showCongratsScreen();
      }
    });
  }

  void resetGame() {
    setState(() {
      _points = 0;
      _isGamePaused = false;
      shuffledFoodArrays = FoodCategories.getShuffledCategories();
    });
    _timerController.startTimer();
  }
}
