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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.fromLTRB(16, 32, 32, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: GColor.scheme.primaryContainer,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BlocBuilder<TodoCubit, TodoState>(
          bloc: todoCubit,
          builder: (context, state) {
            var yInterval = 1.0;
            final maxTodo = state.todos.length;
            if (maxTodo > 100) {
              yInterval = (maxTodo / 10).floorToDouble();
            } else if (maxTodo > 50) {
              yInterval = 20;
            } else if (maxTodo > 25) {
              yInterval = 10;
            } else if (maxTodo > 10) {
              yInterval = 2;
            }
            final todoListByDate = TodoHelper.groupByDate(state.todos);

            return LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                minY: 0,
                minX: 0,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipRoundedRadius: 8,
                    getTooltipItems: (touchedSpots) {
                      if (touchedSpots.length < 2) return [];
                      return [
                        LineTooltipItem(
                          'All: ${touchedSpots[0].y}',
                          TextStyle(
                            color: GColor.scheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        LineTooltipItem(
                          'Done: ${touchedSpots[1].y}',
                          TextStyle(
                            color: GColor.scheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ];
                    },
                    getTooltipColor: (touchedSpot) {
                      return GColor.scheme.surfaceBright;
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    axisNameSize: 16,
                    sideTitles: SideTitles(
                      getTitlesWidget: (value, meta) {
                        // Offset for the date in graph
                        value++;
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
                    dotData: FlDotData(show: false),
                    dashArray: [8, 8],
                    barWidth: 4,
                    isStrokeCapRound: true,
                    color: GColor.scheme.inversePrimary,
                    spots: getAllTodo(todoListByDate, isCompletedOnly: true),
                  ),
                  LineChartBarData(
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
    var copiedTodo = List.of(todos);
    if (isCompletedOnly) {
      copiedTodo = copiedTodo
          .map((e) => e.where((todo) => todo.isCompleted).toList())
          .toList();
    }
    var all7DaysTodo = List.filled(
      7 - copiedTodo.length,
      <Todo>[],
      growable: true,
    );

    all7DaysTodo.addAll(copiedTodo);

    final allSpot = <FlSpot>[];

    for (var i = 0; i < all7DaysTodo.length; i++) {
      final flSpot = FlSpot(i.toDouble(), all7DaysTodo[i].length.toDouble());
      allSpot.add(flSpot);
    }

    return allSpot;
  }
}
