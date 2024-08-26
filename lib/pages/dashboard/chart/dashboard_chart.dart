import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/helper/dependency_helper.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/helper/todo_helper.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardChart extends StatefulWidget {
  const DashboardChart({super.key});

  @override
  State<DashboardChart> createState() => _DashboardChartState();
}

class _DashboardChartState extends State<DashboardChart> {
  final maxTodo = 150;
  final todoCubit = TodoCubit(
    DependencyHelper.todoRepository,
    filter: Filter(
      startDate: DateTime.now().subtract(const Duration(days: 7)),
      endDate: DateTime.now(),
    ),
  );

  @override
  void initState() {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BlocBuilder<TodoCubit, TodoState>(
          bloc: todoCubit,
          builder: (context, state) {
            var yInterval = 2.0;
            final maxTodo = state.todos.length;
            if (maxTodo > 100) {
              yInterval = (maxTodo / 10).floorToDouble();
            } else if (maxTodo > 50) {
              yInterval = 20;
            } else if (maxTodo > 25) {
              yInterval = 10;
            }

            final todoListByDate = TodoHelper.groupByDate(state.todos);

            return LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                minY: 0,
                minX: 0,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameSize: 16,
                    sideTitles: SideTitles(
                      getTitlesWidget: (value, meta) {
                        final now = DateTime.now();
                        final day = 7 - value.toInt();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${now.subtract(Duration(days: day)).day}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                      showTitles: true,
                      interval: 1,
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    axisNameSize: 16,
                    sideTitles: SideTitles(
                      getTitlesWidget: (value, meta) {
                        final isInInterval = value % yInterval == 0;
                        if (value >= 0 && isInInterval) {
                          return SizedBox(
                            width: 16,
                            child: Text(
                              '${value.toInt()}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }

                        return SizedBox.shrink();
                      },
                      showTitles: true,
                      interval: yInterval,
                      reservedSize: 32,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: GColor.scheme.primaryContainer,
                    ),
                  ),
                ),
                rangeAnnotations: RangeAnnotations(
                  horizontalRangeAnnotations: [],
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    dashArray: [8, 8],
                    barWidth: 4,
                    isStrokeCapRound: true,
                    color: GColor.scheme.inversePrimary,
                    spots: getAllTodo(todoListByDate, isCompletedOnly: true),
                  ),
                  LineChartBarData(
                    isCurved: true,
                    dotData: FlDotData(show: false),
                    color: GColor.scheme.primary,
                    isStrokeCapRound: true,
                    barWidth: 4,
                    spots: getAllTodo(todoListByDate),
                  ),
                ],
              ),
              curve: Curves.fastOutSlowIn,
            );
          },
        ),
      ),
    );
  }

  List<FlSpot> getAllTodo(
    List<List<Todo>> todos, {
    bool isCompletedOnly = false,
  }) {
    var all7DaysTodo = List.of(todos);
    if (isCompletedOnly) {
      all7DaysTodo = all7DaysTodo
          .map((e) => e.where((todo) => todo.isCompleted).toList())
          .toList();
    }

    while (all7DaysTodo.length < 7) {
      all7DaysTodo.add([]);
    }

    all7DaysTodo = all7DaysTodo.reversed.toList();

    final allSpot = <FlSpot>[];

    for (var i = 0; i < all7DaysTodo.length; i++) {
      final flSpot = FlSpot(i.toDouble(), all7DaysTodo[i].length.toDouble());
      allSpot.add(flSpot);
    }

    return allSpot;
  }
}
