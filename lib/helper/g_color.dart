import 'package:checklistapp/pages/wrapper.dart';
import 'package:flutter/material.dart';

class GColor {
  const GColor._();
  static ColorScheme get scheme =>
      Theme.of(wrapperKey.currentContext!).colorScheme;

  static String _fontFamily = 'Nunito';
  static Color _seedColor = Colors.deepPurple;
  static void setSeedColor(Color color) => _seedColor = color;

  // Theme Data to put into Material App
  static ThemeData get light => ThemeData(
        fontFamily: _fontFamily,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: inputDecorationTheme,
        bottomNavigationBarTheme: navTheme,
      );

  static ThemeData get dark => ThemeData(
        fontFamily: _fontFamily,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: inputDecorationTheme,
        bottomNavigationBarTheme: navTheme,
      );

  static final navTheme = BottomNavigationBarThemeData(
    unselectedLabelStyle: TextStyle(fontSize: 14),
    selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );

  static final inputDecorationTheme = InputDecorationTheme(
    isCollapsed: true,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(width: 1),
    ),
  );
}
