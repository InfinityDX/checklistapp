import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/components/todo_component.dart';
import 'package:checklistapp/constants/cubit_state_enum.dart';
import 'package:checklistapp/helper/dependency_helper.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
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
        endDate: dateNow.add(const Duration(days: 1)),
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
}
