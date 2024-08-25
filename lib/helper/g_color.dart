import 'package:checklistapp/app.dart';
import 'package:flutter/material.dart';

class GColor {
  const GColor._();
  static ColorScheme get scheme =>
      Theme.of(materialAppKey.currentContext!).colorScheme;

  static Color _seedColor = Colors.deepPurple;
  static void setSeedColor(Color color) => _seedColor = color;

  // Theme Data to put into Material App
  static ThemeData get light => ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ),
        bottomNavigationBarTheme: navTheme,
      );

  static ThemeData get dark => ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
        bottomNavigationBarTheme: navTheme,
      );

  static final navTheme = BottomNavigationBarThemeData(
    unselectedLabelStyle: TextStyle(fontSize: 14),
    selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );
}
