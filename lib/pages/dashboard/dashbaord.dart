import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/constants/cubit_state_enum.dart';
import 'package:checklistapp/helper/dependency_helper.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:checklistapp/pages/dashboard/chart/dashboard_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashbaord extends StatefulWidget {
  const Dashbaord({super.key});

  @override
  State<Dashbaord> createState() => _DashbaordState();
}

class _DashbaordState extends State<Dashbaord> {
  final todayTodo = TodoCubit(
    DependencyHelper.todoRepository,
    filter: Filter(startDate: DateTime.now(), endDate: DateTime.now()),
  );

  @override
  void initState() {
    todayTodo.getTodos();
    super.initState();
  }

  @override
  void dispose() {
    todayTodo.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          // Charts
          SliverToBoxAdapter(
            child: DashboardChart(),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Today's Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          BlocBuilder<TodoCubit, TodoState>(
            bloc: todayTodo,
            builder: (context, state) {
              if (state.status == CubitStatus.gettingData) {
                return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }

              if (state.todos.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No tasks today!",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Container();
                  },
                  childCount: state.todos.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
