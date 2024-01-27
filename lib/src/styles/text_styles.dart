
import 'package:flutter/material.dart';

class TextStyles {
  final TextTheme primaryTextTheme = const TextTheme(
    titleSmall: TextStyle(fontSize: 18, color: Colors.white),
    titleLarge: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 30, color: Colors.white),
    labelSmall: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 25, color: Colors.black38, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
  );

  TextStyle? changeColor (TextStyle? style, Color color){
    TextStyle? newStyle = style?.apply(color: color);
    return newStyle;
  }
}