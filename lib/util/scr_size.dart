import 'package:flutter/widgets.dart';

class ScrSize {
  //Get the size of the screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  //Gets the height of the screen
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}


