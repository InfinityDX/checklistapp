import 'package:checklistapp/bloc/theme_cubit/theme_cubit.dart';
import 'package:checklistapp/components/global_blocs_provider.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> materialAppKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBlocsProvider(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: materialAppKey,
            title: 'Flutter Demo',
            theme: GColor.light,
            darkTheme: GColor.dark,
            themeMode: state.mode,
            // themeMode: ThemeMode.dark,
            home: const Wrapper(),
          );
        },
      ),
    );
  }
}
