import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/components/todo_component.dart';
import 'package:checklistapp/constants/cubit_state_enum.dart';
import 'package:checklistapp/helper/dependency_helper.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin {
  var focusedDate = DateTime.now();
  late TodoCubit todoCubit;

  @override
  void initState() {
    final now = DateTime.now();
    final dateNow = DateTime(now.year, now.month, now.day);
    todoCubit = TodoCubit(
      DependencyHelper.todoRepository,
      filter: Filter(
        startDate: dateNow,
        endDate: dateNow.add(const Duration(hours: 23)),
      ),
    );
    todoCubit.getTodos();
    super.initState();
  }

  @override
  void dispose() {
    todoCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Theme.of(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Calendar',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: EasyInfiniteDateTimeLine(
              controller: EasyInfiniteDateTimelineController(),
              firstDate: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              focusDate: focusedDate,
              lastDate: DateTime(2100),
              headerBuilder: (context, date) {
                final textStyle = TextStyle(
                  color: GColor.scheme.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                );
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        DateFormat("EEEE").format(date),
                        style: textStyle,
                      )),
                      Text(
                        DateFormat("d/mm/yyyy").format(date),
                        style: textStyle,
                      )
                    ],
                  ),
                );
              },
              dayProps: EasyDayProps(
                activeDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: GColor.scheme.onPrimaryContainer,
                  ),
                  dayStrStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: GColor.scheme.onPrimaryContainer,
                  ),
                  monthStrStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: GColor.scheme.onPrimaryContainer,
                  ),
                  decoration: BoxDecoration(
                    color: GColor.scheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                inactiveDayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: GColor.scheme.onSurface,
                  ),
                  decoration: BoxDecoration(
                    color: GColor.scheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                todayStyle: DayStyle(
                  dayNumStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: GColor.scheme.onSurface,
                  ),
                  decoration: BoxDecoration(
                    color: GColor.scheme.surfaceContainer,
                    border: Border.all(
                      color: GColor.scheme.primaryContainer,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              onDateChange: (selectedDate) {
                if (focusedDate == selectedDate) return;
                focusedDate = selectedDate;
                final oldCubit = todoCubit;
                todoCubit = TodoCubit(
                  DependencyHelper.todoRepository,
                  filter: Filter(
                    startDate: selectedDate,
                    endDate: selectedDate.add(const Duration(days: 1)),
                  ),
                );
                todoCubit.getTodos();
                setState(() {});
                oldCubit.close();
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<TodoCubit, TodoState>(
              bloc: todoCubit,
              builder: (context, state) {
                if (state.status == CubitStatus.gettingData) {
                  return Center(child: CircularProgressIndicator.adaptive());
                }

                if (state.todos.isEmpty) {
                  return Center(
                    child: Text(
                      "No tasks on this date!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return TodoComponent(todo: todo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
