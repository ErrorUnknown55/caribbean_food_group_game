import 'dart:ui';

import 'package:caribbean_food_group_game/util/color_palette.dart';
import 'package:flutter/material.dart';

class appTheme {
  //Light theme
  static ThemeData light_theme = _buildThemeData(
    brightness: Brightness.light,
    primaryColor: colorPalette.shade400,
    primaryTextColor: colorPalette.shade50,
    secondaryTextColor: colorPalette.shade400,

  );

  //Builds a ThemeData object with customized styles for both light and dark themes.
  static ThemeData _buildThemeData({
    required Brightness brightness,
    required Color primaryColor,
    required Color primaryTextColor,
    required Color secondaryTextColor,

  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryColor,
      textTheme: _buildTextTheme(primaryTextColor, secondaryTextColor),
      iconTheme: IconThemeData(color: primaryColor),
    );
  }

  /// Builds a customized text theme with Poppins font.
  static TextTheme _buildTextTheme(Color primaryTextColor, Color secondaryTextColor){
    return TextTheme(
      //Screen tile
      displaySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: primaryTextColor),
    );
  }
}