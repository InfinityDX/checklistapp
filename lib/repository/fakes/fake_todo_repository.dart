import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:checklistapp/models/pagination.dart';
import 'package:checklistapp/repository/fakes/fake_todo_data.dart';
import 'package:checklistapp/repository/interfaces/i_todo_repository.dart';

class FakeTodoRepository implements ITodoRepository {
  final fakeData = FakeTodoData();

  @override
  Future<List<Todo>> getTodos({
    Filter filter = const Filter(),
    Pagination pagination = const Pagination(),
  }) async {
    return fakeData.todos;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    return fakeData.todos.add(todo);
  }

  @override
  Future<bool> updateTodo(Todo todo) async {
    final fakeTodoIndex = fakeData.todos.indexOf(todo);
    if (fakeTodoIndex < 0) return false;
    fakeData.todos[fakeTodoIndex] = todo;
    return true;
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
