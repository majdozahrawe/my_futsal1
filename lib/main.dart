import 'package:flutter/material.dart';
import 'package:my_futsal/screens/home_screen_admin.dart';
import 'package:my_futsal/screens/login_reg/ui/signin.dart';
import 'package:my_futsal/screens/login_reg/ui/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:my_futsal/provider/theme_provider.dart';
import 'package:my_futsal/screens/home_screen.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (_) => ThemeProvider(isLightTheme: true),
  child: MyApp(),
),);

class MyApp extends StatelessWidget {
  ThemeMode themeMode = ThemeMode.light;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Graduate Project',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode, // Change it
      theme: themeProvider.getThemeData,// as you want
      home: HomePage(),
    );
  }


}

