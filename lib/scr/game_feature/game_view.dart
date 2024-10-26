import 'package:caribbean_food_group_game/scr/home_feature/home_page.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});
  static const routeName ='/gameview';

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));},
              icon: const Icon(Icons.home)),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.pause))
        ],
      ),
    );
  }
}
