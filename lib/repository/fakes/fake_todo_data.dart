import 'package:checklistapp/models/entities/todo.entity.dart';

class FakeTodoData {
  List<Todo> todos = [];

  FakeTodoData() {
    todos.addAll(List.generate(10, (index) {
      return Todo(
        id: index,
        title: 'Todo $index',
        isCompleted: false,
        isPrioritized: false,
        createdDate: DateTime(2024, 1, 1),
      );
    }));

    todos.addAll(List.generate(5, (index) {
      return Todo(
        id: index,
        title: 'Todo $index',
        isCompleted: false,
        isPrioritized: false,
        createdDate: DateTime(2024, 1, 2),
      );
    }));
  }
}
