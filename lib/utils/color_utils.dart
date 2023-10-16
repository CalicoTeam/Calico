import 'package:flutter/cupertino.dart';

Color hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}

class CalicoColors {
  // representative colors #1
  static Color representBlack = hexStringToColor("#000000");
  static Color representOrange = hexStringToColor("#ffa545");
  static Color representWhite = hexStringToColor("#ffffff");

  // representative colors #2
  // static Color representBlack = hexStringToColor("#121212");
  // static Color representOrange = hexStringToColor("#f39233");
  // static Color representWhite = hexStringToColor("#fafafa");
}
