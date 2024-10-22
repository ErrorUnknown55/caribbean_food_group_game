import 'package:caribbean_food_group_game/scr/game_feature/game_view.dart';
import 'package:caribbean_food_group_game/scr/home_feature/homePage.dart';
import 'package:caribbean_food_group_game/scr/setting_feature/setting_view.dart';
import 'package:caribbean_food_group_game/util/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key,});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        restorationScopeId: 'app',

        //This line of code sets the theme for the current widget or component
        //to the light_theme defined in the appTheme class.
        theme: appTheme.light_theme,

        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case HomePage.routeName:
                  return const HomePage();
                case SettingsView.routeName:
                  return const SettingsView();
                case GameView.routeName:
                  return const GameView();
                default:
                  return const HomePage();
              }
            },
          );
        }
        );
  }
}



