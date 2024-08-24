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
      final i = index + todos.last.id + 1;
      return Todo(
        id: i,
        title: 'Todo $index',
        isCompleted: false,
        isPrioritized: false,
        createdDate: DateTime(2024, 1, 2),
      );
    }));

    todos.addAll(List.generate(15, (index) {
      final i = index + todos.last.id + 1;
      return Todo(
        id: i,
        title: 'Todo $index',
        isCompleted: false,
        isPrioritized: false,
        createdDate: DateTime(2024, 1, 3),
      );
    }));

    todos.addAll(List.generate(3, (index) {
      final i = index + todos.last.id + 1;
      return Todo(
        id: i,
        title: 'Todo $index',
        isCompleted: false,
        isPrioritized: false,
        createdDate: DateTime(2024, 1, 4),
      );
    }));
  }
}
