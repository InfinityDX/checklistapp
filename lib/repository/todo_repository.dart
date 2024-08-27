import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:checklistapp/objectbox.g.dart';
import 'package:checklistapp/repository/interfaces/i_todo_repository.dart';
import 'package:checklistapp/services/db.dart';

class TodoRepository implements ITodoRepository {
  @override
  Future<List<Todo>> getTodos({
    Filter filter = const Filter(),
  }) {
    final dateNow = DateTime.now();

    var condition = Todo_.createdDate.betweenDate(
      filter.startDate ?? DateTime(dateNow.year, dateNow.month, dateNow.day),
      filter.endDate ?? DateTime(dateNow.year, dateNow.month, dateNow.day),
    );

    if (filter.isCompleted != null) {
      condition = condition.and(Todo_.isCompleted.equals(filter.isCompleted!));
    }

    final query = DB.todoBox
        .query(condition)
        .order(Todo_.isPrioritized, flags: Order.descending)
        .order(Todo_.createdDate, flags: filter.order)
        .build();

    return query.findAsync();
  }

  Future<Stream<Query<Todo>>?> watchTodo({
    Filter filter = const Filter(),
  }) async {
    final dateNow = DateTime.now();

    var condition = Todo_.createdDate.betweenDate(
      filter.startDate ?? DateTime(dateNow.year, dateNow.month, dateNow.day),
      filter.endDate ?? DateTime(dateNow.year, dateNow.month, dateNow.day),
    );

    if (filter.isCompleted != null) {
      condition = condition.and(Todo_.isCompleted.equals(filter.isCompleted!));
    }

    final sub = DB.todoBox
        .query(condition)
        .order(Todo_.isPrioritized, flags: Order.descending)
        .order(Todo_.createdDate, flags: filter.order)
        .watch(triggerImmediately: true);

    return sub;
  }

  @override
  Future<Todo> addTodo(Todo todo) {
    return DB.todoBox.putAndGetAsync(todo, mode: PutMode.insert);
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    return DB.todoBox.putAndGetAsync(todo, mode: PutMode.update);
  }

  @override
  Future<bool> deleteTodo(int id) {
    return DB.todoBox.removeAsync(id);
  }
}
