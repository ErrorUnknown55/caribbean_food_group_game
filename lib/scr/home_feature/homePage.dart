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
          backgroundColor: Colors.transparent,
        ),
        endDrawer: const Drawer(child: SettingsView()),
      ),
    );
  }
}
