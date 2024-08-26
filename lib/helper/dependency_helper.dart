import 'package:checklistapp/repository/interfaces/i_todo_repository.dart';
import 'package:checklistapp/repository/todo_repository.dart';

class DependencyHelper {
  const DependencyHelper._();

  static ITodoRepository get todoRepository => TodoRepository();
}
