import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;
  ThemeProvider({this.isLightTheme});
  ThemeData get getThemeData =>  lightTheme;
}
final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);