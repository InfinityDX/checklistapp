import 'package:checklistapp/bloc/theme_cubit/theme_cubit.dart';
import 'package:checklistapp/pages/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return SettingsTile(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Switch.adaptive(
                      value: state.mode == ThemeMode.dark,
                      onChanged: (isDark) {
                        if (isDark) {
                          BlocProvider.of<ThemeCubit>(context)
                              .changeThemeMode(ThemeMode.dark);
                        } else {
                          BlocProvider.of<ThemeCubit>(context)
                              .changeThemeMode(ThemeMode.light);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
