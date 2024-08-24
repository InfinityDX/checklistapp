import 'package:checklistapp/helper/extensions/date_extensions.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:checklistapp/repository/fakes/fake_todo_data.dart';
import 'package:checklistapp/repository/interfaces/i_todo_repository.dart';

class FakeTodoRepository implements ITodoRepository {
  final fakeData = FakeTodoData();

  @override
  Future<List<Todo>> getTodos({Filter filter = const Filter()}) async {
    return fakeData.todos.where((todo) {
      if (todo.createdDate == null) return false;
      return todo.createdDate!.isBetween(filter.startDate, filter.endDate);
    }).toList();
  }

  @override
  Future<Todo?> addTodo(Todo todo) async {
    final lastId = fakeData.todos.lastOrNull?.id ?? -1;
    todo.id = lastId + 1;
    fakeData.todos.add(todo);
    return todo;
  }

  @override
  Future<Todo?> updateTodo(Todo todo) async {
    final fakeTodo = fakeData.todos.firstWhere((todo) => todo.id == todo.id);
    final fakeTodoIndex = fakeData.todos.indexOf(fakeTodo);
    if (fakeTodoIndex < 0) return null;
    fakeData.todos[fakeTodoIndex] = todo;
    return todo;
  }

  @override
  Future<bool> deleteTodo(int id) async {
    final foundTodo = fakeData.todos.firstWhere(
      (todo) => todo.id == id,
      orElse: () => Todo(id: -1),
    );
    if (foundTodo.id < 0) return false;
    fakeData.todos.remove(foundTodo);
    return true;
  }
}
