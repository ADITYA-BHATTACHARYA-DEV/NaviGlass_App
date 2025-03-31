import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.deepPurpleAccent,
  textTheme: const TextTheme(
    headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
    bodyText1: TextStyle(fontSize: 16, color: Colors.white70),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.cyanAccent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
);
