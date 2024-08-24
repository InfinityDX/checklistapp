import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getTodos({Filter filter = const Filter()});
  Future<Todo?> addTodo(Todo todo);
  Future<Todo?> updateTodo(Todo todo);
  Future<bool> deleteTodo(int id);
}
