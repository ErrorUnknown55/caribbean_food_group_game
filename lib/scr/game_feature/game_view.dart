import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:caribbean_food_group_game/scr/game_over_feature/game_over_view.dart';
import 'package:caribbean_food_group_game/scr/setting_feature/setting_view.dart';
import 'package:caribbean_food_group_game/scr/victory_features/victory_view.dart';
import 'package:caribbean_food_group_game/util/scr_size.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});
  static const routeName ='/gameview';

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {

  // Game variables
  late Timer _timer;
  int _points = 0;
  final int _dealCost = 5;
  int _dealCountdown = 5;
  int _timeRemaining = 60;
  Color _timerColor = Colors.black;
  bool _gameOver = false;
  bool _dealActive = false;
  bool _isGamePaused = false;
  bool _dealerAvailable = true;
  bool _isPauseMenuVisible = false;


  //Food items list
  List<String> food = [
    'Bread', 'Corn', 'Cornmeal', 'Flour', 'Pasta', 'Rice','Porridge', 'Green fig', 'Plantain', 'Breadfruit', 'Dasheen', 'Cassava', 'Potato', 'Sweet potato',
    'Carrot', 'Patchoi', 'Callaloo', 'Lettuce', 'Pumpkin', 'Green Pepper', 'Eggplant', 'String beans', 'Cauliflower', 'Broccoli', 'Christophene', 'Cucumber', 'Tomato',
    'Oranges', 'Grapefruit', 'Portugal', 'Watermelon', 'Pommecythere', 'Tamarind', 'Guava', 'Pommerac', 'West Indian Cherry', 'Soursop', 'Lime', 'Papaw', 'Banana',
    'Red beans', 'Lentils', 'Pigeon Pies', 'Black-eyed peas', 'Channa', 'Peanuts', 'Almonds', 'Cashew nut', 'Sesame seeds', 'Pumpkin Seeds', 'Flax/linsed',
    'Chicken', 'Fish', 'Milk', 'Cheese', 'Yogurt', 'Eggs', 'Liver', 'Beef', 'Ox-tail',
    'Cooking oil', 'Avocado', 'Olives', 'Butter', 'Margarine', 'Ghee', 'Coconut milk', 'Ackee',
  ];

  // Categorized food items
  Map<String, List<String>> foodArrays = {
    'Staples': ['Bread', 'Corn', 'Cornmeal', 'Flour', 'Pasta', 'Rice','Porridge', 'Green fig', 'Plantain', 'Breadfruit', 'Dasheen', 'Cassava', 'Potato', 'Sweet potato'],
    'Vegetables': ['Carrot', 'Patchoi', 'Callaloo', 'Lettuce', 'Pumpkin', 'Green Pepper', 'Eggplant', 'String beans', 'Cauliflower', 'Broccoli', 'Christophene', 'Cucumber', 'Tomato'],
    'Fruits': ['Oranges', 'Grapefruit', 'Portugal', 'Watermelon', 'Pommecythere', 'Tamarind', 'Guava', 'Pommerac', 'West Indian Cherry', 'Soursop', 'Lime', 'Papaw', 'Banana'],
    'Legumes': ['Red beans', 'Lentils', 'Pigeon Pies', 'Black-eyed peas', 'Channa', 'Peanuts', 'Almonds', 'Cashew nut', 'Sesame seeds', 'Pumpkin Seeds', 'Flax/linsed'],
    'Food from Animals': [ 'Chicken', 'Fish', 'Milk', 'Cheese', 'Yogurt', 'Eggs', 'Liver', 'Beef', 'Ox-tail'],
    'Fat and Oils': ['Cooking oil', 'Avocado', 'Olives', 'Butter', 'Margarine', 'Ghee', 'Coconut milk', 'Ackee'],
  };

  // Shuffled food items for the game
  Map<String, List<String>> shuffledFoodArrays = {};

  @override
  void initState() {
    super.initState();
    shuffleArrays();
    startTimer();
  }


// Inside _GameScreenState class
  void gameOver() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameOverView(finalPoints: _points),
      ),
    );
  }

  void showCongratsScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VictoryView(finalPoints: _points, timeTaken: 60 - _timeRemaining),
      ),
    );
  }

  // Hide pause menu
  void hidePauseMenu() {
    setState(() {
      _isPauseMenuVisible = false;
    });
  }

  // Pause the game
  void pauseGame() {
    setState(() {
      _isGamePaused = true;
      _timer.cancel();
    });
  }
  // Resume the game
  void resumeGame() {
    setState(() {
      _isGamePaused = false;
      _dealActive = false; // Reset deal status
      startTimer();
    });
  }


  // Timer setup and dealer appearance logic
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0 && !_dealActive) {
          _timeRemaining--;

          // Use a random number between 3 and 15 for dealer appearance
          final random = Random();
          final dealerAppearanceTime = random.nextInt(13) + 3;

          if (_timeRemaining == dealerAppearanceTime && _dealerAvailable && _points >= 5) {
            showDealerDeal();
          }

          if (_timeRemaining <= 15) {
            _timerColor =
            _timerColor == Colors.red ? Colors.black : Colors.red;
          }
        } else {
          _timer.cancel();
          setState(() {
            _gameOver = true;
          });
          gameOver(); // Call the gameOver method
        }
      });
    });
  }



  // Show dealer deal dialog
  void showDealerDeal() {
    _dealerAvailable = false;
    _dealActive = true;
    _dealCountdown = 5;
    _timer.cancel();

    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
            'Dealer Offer',
            style: TextStyle(fontWeight: FontWeight.bold)
        ),
        content: _buildDealerDialogContent(),
        actions: _buildDealerDialogActions(context), // Pass context to the function
      );
    },
    );
  }



  // Countdown logic for the dealer deal dialog
  Future<void> _updateCountdown(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_dealActive) {
        timer.cancel();
      } else {
        setState(() {
          _dealCountdown--;
        });

        if (_dealCountdown <= 0) {
          Navigator.of(context).pop();
          resumeGame();
          timer.cancel();
        }
      }
    });
  }


  // Actions in the dealer deal dialog
  List<Widget> _buildDealerDialogActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () async {
          Navigator.of(context).pop();
          await _updateCountdown(context);
          resumeGame();
        },
        child: const Text('Decline',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
            )
        ),
      ),
      TextButton(
        onPressed: () async {
          setState(() {
            _points -= _dealCost;
            _timeRemaining += 10;
          });
          Navigator.of(context).pop();
          await _updateCountdown(context);
          resumeGame();
        },
        child: const Text('Accept',
            style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.green
            )
        ),
      ),
    ];
  }



  // Content of the dealer deal dialog
  Widget _buildDealerDialogContent() {
    return Container(
      height: 65,
      child: Column(
        children: [
          Text('Would you like to buy 10 seconds for $_dealCost points?',),
          const SizedBox(height: 5),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }



  // Reset game state
  void resetGame() {
    setState(() {
      _gameOver = false;
      _points = 0;
      _timerColor = Colors.black;
      _timeRemaining = 60;
      _isGamePaused = false;
      _dealerAvailable = true; // Reset dealer availability
      shuffleArrays();
      _isPauseMenuVisible = false;
    });
    startTimer();
  }


  // Shuffle food arrays for the game
  void shuffleArrays() {
    final random = Random();

    for (var key in foodArrays.keys) {
      var list = List<String>.from(foodArrays[key]!);
      list.shuffle(random);
      shuffledFoodArrays[key] = list.take(5).toList();//List of food items
    }
    // Shuffle the order of the categories
    var keys = shuffledFoodArrays.keys.toList();
    keys.shuffle(random);

    // Create a new map with shuffled categories
    var shuffledMap = Map<String, List<String>>();
    keys.forEach((key) {
      shuffledMap[key] = shuffledFoodArrays[key]!;
    });

    // Update shuffledFoodArrays with the shuffled categories
    shuffledFoodArrays = shuffledMap;
  }


  ///Game
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.popAndPushNamed(context, '/homepage'),
              icon: const Icon(Icons.home)),
        actions: [
          IconButton(onPressed: () {
            pauseGame();
            showPauseMenu();
          },
              icon: const Icon(Icons.pause))
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_gameOver) {
            return true;
          } else if (_isPauseMenuVisible) {
            hidePauseMenu();
            return false;
          } else {
            return false;
          }
        },
        child: AbsorbPointer(
          absorbing: _isGamePaused,
          child: SafeArea(
            child: Stack(
              children: [
                Scaffold(
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      //Handles the Points and Time display
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ScrSize.getScreenWidth(context) * 0.015),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Points: $_points',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _points < 0 ? Colors.red : (_points == 0 ? Colors.black : Colors.green),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              'Time: ${_timeRemaining ~/ 60}:${(_timeRemaining % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _timerColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: shuffledFoodArrays.values.expand((list) {
                              return list.map((shape) {
                                return AnimatedOpacity(
                                  duration: const Duration(seconds: 1),
                                  opacity: _isGamePaused ? 0.5 : 1.0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: ScrSize.getScreenWidth(context) * 0.02),
                                    child: Draggable<String>(
                                      data: shape,
                                      child: _buildShape(shape),
                                      feedback: _buildShape(shape, isFeedback: true),
                                      childWhenDragging: Container(),
                                    ),
                                  ),
                                );
                              });
                            }).toList(),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: ScrSize.getScreenWidth(context) * 0.065),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTarget('Staples'),
                            _buildTarget('Vegetables'),
                            _buildTarget('Fruits'),
                            _buildTarget('Legumes'),
                            _buildTarget('Food from Animals'),
                            _buildTarget('Fat and Oils'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                if (_isGamePaused && _isPauseMenuVisible)
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // Show pause menu dialog
  void showPauseMenu() {
    setState(() {
      _isPauseMenuVisible = true;
    });

    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          // Prevent back navigation when the pause menu is visible
          return false;
        },
        //TODO: Add equation to adjust for screen size
        child: AlertDialog(
          title: const Text('Pause Menu',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: ScrSize.getScreenWidth(context) * 0.015),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resumeGame();
                },
                child: const Text('Resume',),
              ),


              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                child: const Text('Restart',),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
                child: const Text('Main Menu'),
              ),

              ElevatedButton(
                onPressed: () {

                  //Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsView()));
                },
                child: const Text('Settings'),
              ),
            ],
          ),
        ),
      );
    },
    );
  }

  // Build draggable food item widget
  Widget _buildShape(String shape, {bool isFeedback = false}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.2,
      color: isFeedback ? Colors.grey : Colors.blue,
      child: Center(
        child: Text(
          shape,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.025,// Handles the text size
          ),
        ),
      ),
    );
  }

  // Build drop target widget
  Widget _buildTarget(String shape) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.14,
          height: MediaQuery.of(context).size.height * 0.2,
          color: Colors.green,
          child: Center(
            child: Text(
              shape,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.025,// Handles the text size
              ),
            ),
          ),
        );
      },
      onAccept: (data) {
        setState(() {
          if (shuffledFoodArrays[shape]!.contains(data)) {
            _points += 1; // Correct guess
          } else {
            _points -= 1; // Incorrect guess
          }
          shuffledFoodArrays[shape]!.remove(data); // Removes dragged item from the target

          // Check if all lists in shuffledFoodArrays are empty
          bool allEmpty = shuffledFoodArrays.values.every((list) => list.isEmpty);

          if (allEmpty) {
            showCongratsScreen();
          }
        });
      },
      onLeave: (data) {
        // Handle when the dragged shape leaves the target
      },
    );
  }

}


