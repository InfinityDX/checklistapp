import 'package:checklistapp/models/entities/todo.entity.dart';

class TodoHelper {
  const TodoHelper._();

  static List<List<Todo>> groupByDate(List<Todo> todos) {
    Map<DateTime, List<Todo>> groupedByDate = {};

    for (var todo in todos) {
      // Extract the date part only (without time)
      final createdDate = todo.createdDate;
      if (createdDate == null) continue;
      DateTime dateOnly = DateTime(
        createdDate.year,
        createdDate.month,
        createdDate.day,
      );
      // Add the datetime to the appropriate group
      if (!groupedByDate.containsKey(dateOnly)) {
        groupedByDate[dateOnly] = [];
      }
      groupedByDate[dateOnly]!.add(todo);
    }
    return groupedByDate.values.toList();
  }
}
