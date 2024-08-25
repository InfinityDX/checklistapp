import 'package:bloc/bloc.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/helper/hive/general_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    init();
  }

  void init() {
    final savedThemeMode =
        GeneralStorage.get('themeMode', defaultValue: 'light');
    final savedColor =
        GeneralStorage.get('color', defaultValue: Colors.deepPurple.value);
    final themeMode =
        ThemeMode.values.firstWhere((mode) => mode.name == savedThemeMode);

    GColor.setSeedColor(Color(savedColor));
    emit(state.copyWith(mode: themeMode));
  }

  void changeColor(Color color) {
    GeneralStorage.put('color', color.value);
    GColor.setSeedColor(color);
    emit(state.copyWith(color: color));
  }

  void changeThemeMode(ThemeMode mode) {
    GeneralStorage.put('themeMode', mode.name);
    emit(state.copyWith(mode: mode));
  }
}
