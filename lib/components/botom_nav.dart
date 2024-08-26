import 'package:checklistapp/bloc/page_cubit/page_cubit.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentTabIndex,
      onTap: (index) {
        setState(() => currentTabIndex = index);
        final type = PageType.values[index];

        BlocProvider.of<PageCubit>(context).changePageTo(type);
      },
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(FluentIcons.home_24_filled),
          icon: Icon(FluentIcons.home_24_regular),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(FluentIcons.calendar_24_filled),
          icon: Icon(FluentIcons.calendar_24_regular),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(FluentIcons.settings_24_filled),
          icon: Icon(FluentIcons.settings_24_regular),
          label: 'Settings',
        ),
      ],
    );
  }
}
