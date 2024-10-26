import 'package:caribbean_food_group_game/scr/game_feature/game_view.dart';
import 'package:caribbean_food_group_game/scr/setting_feature/setting_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName ='/homepage';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Caribbean Food Group',
            style: theme.textTheme.displaySmall),
          //backgroundColor: Colors.transparent,
        ),
        endDrawer: const Drawer(child: SettingsView()),

        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const GameView()));
                      },
                      child: Text('Start',
                      style: theme.textTheme.headlineSmall),
                    ),
                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }
}
