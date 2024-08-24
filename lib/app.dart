import 'package:checklistapp/components/global_blocs_provider.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/pages/wrapper.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> materialAppKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalBlocsProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: GColor.light,
        darkTheme: GColor.dark,
        themeMode: ThemeMode.dark,
        home: const Wrapper(),
      ),
    );
  }
}
