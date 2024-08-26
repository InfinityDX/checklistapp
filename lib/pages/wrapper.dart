import 'package:checklistapp/bloc/page_cubit/page_cubit.dart';
import 'package:checklistapp/components/botom_nav.dart';
import 'package:checklistapp/pages/add_todo/add_todo_page.dart';
import 'package:checklistapp/pages/calendar/calendar_page.dart';
import 'package:checklistapp/pages/dashboard/dashbaord.dart';
import 'package:checklistapp/pages/settings/settings_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> wrapperKey = GlobalKey<NavigatorState>();

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: wrapperKey,
      body: Stack(children: [
        BlocBuilder<PageCubit, PageState>(
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
      ]),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            onPressed: () => showAddTodoSheet(context),
            shape: CircleBorder(),
            child: Icon(FluentIcons.add_24_regular),
          );
        },
      ),
      bottomNavigationBar: BottomNav(),
    );
  }

  void showAddTodoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddTodoPage();
      },
    );
  }
}
