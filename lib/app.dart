import 'package:caribbean_food_group_game/scr/home_feature/homePage.dart';
import 'package:caribbean_food_group_game/scr/setting_feature/setting_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key,});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        restorationScopeId: 'app',

        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) {
              switch (routeSettings.name) {
                case HomePage.routeName:
                  return const HomePage();
                case SettingsView.routeName:
                  return const SettingsView();
                default:
                  return const HomePage();
              }
            },
          );
        }
        );
  }
}


