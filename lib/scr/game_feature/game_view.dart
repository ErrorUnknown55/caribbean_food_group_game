import 'package:caribbean_food_group_game/scr/home_feature/homePage.dart';
import 'package:caribbean_food_group_game/scr/setting_feature/setting_view.dart';
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
                MaterialPageRoute(builder: (context) => HomePage()));},
              icon: const Icon(Icons.home)),
      ),
      endDrawer: const SettingsView(),

    );
  }
}
