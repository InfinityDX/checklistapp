import 'package:checklistapp/app.dart';
import 'package:flutter/material.dart';

class GColor {
  const GColor._();
  static ColorScheme get scheme =>
      Theme.of(materialAppKey.currentContext!).colorScheme;

  static final Color seedColor = Colors.deepPurple;

  // Theme Data to put into Material App
  static ThemeData get light => ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        bottomNavigationBarTheme: navTheme,
      );

  static ThemeData get dark => ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        bottomNavigationBarTheme: navTheme,
      );

  static final navTheme = BottomNavigationBarThemeData(
    unselectedLabelStyle: TextStyle(fontSize: 14),
    selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );
}
