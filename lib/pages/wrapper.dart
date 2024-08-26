import 'package:checklistapp/bloc/page_cubit/page_cubit.dart';
import 'package:checklistapp/components/botom_nav.dart';
import 'package:checklistapp/pages/calendar/calendar_page.dart';
import 'package:checklistapp/pages/dashboard/dashbaord.dart';
import 'package:checklistapp/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

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
      bottomNavigationBar: BottomNav(),
    );
  }
}
