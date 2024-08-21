import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:checklistapp/models/pagination.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getTodos({
    Filter filter = const Filter(),
    Pagination pagination = const Pagination(),
  });

  Future<void> addTodo(Todo todo);
  Future<bool> updateTodo(Todo todo);
  Future<bool> deleteTodo(int id);
}
