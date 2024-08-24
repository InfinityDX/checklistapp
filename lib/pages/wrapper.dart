import 'package:checklistapp/bloc/page_cubit/page_cubit.dart';
import 'package:checklistapp/pages/calendar/calendar_page.dart';
import 'package:checklistapp/pages/dashboard/dashbaord.dart';
import 'package:checklistapp/pages/settings/settings_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          switch (state.type) {
            case PageType.dashboard:
              return Dashbaord();
            case PageType.calendar:
              return CalendarPage();
            case PageType.settings:
              return SettingsPage();
            default:
              return Dashbaord();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (index) {
          setState(() => currentTabIndex = index);
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
      ),
    );
  }
}
