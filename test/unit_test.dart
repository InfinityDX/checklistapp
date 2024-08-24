import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:checklistapp/repository/fakes/fake_todo_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Todo Cubit', () {
    test('Get Todo', () async {
      var testDate = DateTime(2024, 1, 1);
      var todoCubit = TodoCubit(
        FakeTodoRepository(),
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 10);
      todoCubit.close();

      testDate = DateTime(2024, 1, 2);
      todoCubit = TodoCubit(
        FakeTodoRepository(),
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 5);
      todoCubit.close();

      testDate = DateTime(2024, 1, 3);
      todoCubit = TodoCubit(
        FakeTodoRepository(),
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 15);
      todoCubit.close();

      testDate = DateTime(2024, 1, 4);
      todoCubit = TodoCubit(
        FakeTodoRepository(),
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 3);
      todoCubit.close();
    });
    test('Add Todo', () async {
      final repository = FakeTodoRepository();
      final testDate = DateTime(2024, 1, 1);
      final todoCubit = TodoCubit(
        repository,
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 10);

      await todoCubit.addTodo(Todo(
        title: 'New Todo Title',
        createdDate: DateTime(2024, 1, 1),
      ));
      expect(todoCubit.state.todos.length, 11);

      // Add a different date then specified in the cubit
      await todoCubit.addTodo(Todo(
        title: 'New Todo Title',
        createdDate: DateTime(2024, 1, 2),
      ));
      // Should be still 11 because the todoCubit only specilaize for todo in date 2024,1,1
      expect(todoCubit.state.todos.length, 11);

      final testDate2 = DateTime(2024, 1, 2);
      final todoCubit2 = TodoCubit(
        repository,
        filter: Filter(startDate: testDate2, endDate: testDate2),
      );
      await todoCubit2.getTodos();
      // Shoul be 6 becuase the original data is 5 and we just added 1 above
      expect(todoCubit2.state.todos.length, 6);
    });

    test('Update Todo', () async {
      final testDate = DateTime(2024, 1, 1);
      final todoCubit = TodoCubit(
        FakeTodoRepository(),
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 10);

      final copiedTodo = todoCubit.state.todos.first.copyWith();
      final oldTitle = copiedTodo.title;
      const newTitle = 'New Todo Title';
      copiedTodo.title = newTitle;
      await todoCubit.updateTodo(copiedTodo);
      expect(todoCubit.state.todos.length, 10);

      // Old todo should not be existed
      final oldTodo = todoCubit.state.todos.firstWhere(
        (todo) => todo.title == oldTitle,
        orElse: () => Todo(id: -1),
      );
      expect(oldTodo.id, -1);

      // Updated todo should be existed
      final updatedTodo = todoCubit.state.todos.firstWhere(
        (todo) => todo.title == newTitle,
        orElse: () => Todo(id: -1),
      );
      expect(updatedTodo.id >= 0, true);
    });
    test('Delete Todo', () async {
      final testDate = DateTime(2024, 1, 1);
      final todoCubit = TodoCubit(
        FakeTodoRepository(),
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 10);

      const todoToDelete = 0;
      await todoCubit.deleteTodo(todoToDelete);
      expect(todoCubit.state.todos.length, 9);
      final deletedTodo = todoCubit.state.todos.firstWhere(
        (todo) => todo.id == todoToDelete,
        orElse: () => Todo(id: -1),
      );
      expect(deletedTodo.id, -1);
      // await todoCubit.deleteTodo(todoToDelete);
      expect(todoCubit.state.todos.length, 9);
    });

    test('Full CRUD', () async {
      final testDate = DateTime(2024, 1, 1);
      final todoCubit = TodoCubit(
        FakeTodoRepository(),
        filter: Filter(startDate: testDate, endDate: testDate),
      );
      expect(todoCubit.state.todos.length, 0);

      // Getting todos
      await todoCubit.getTodos();
      expect(todoCubit.state.todos.length, 10);

      // Adding new todo
      const newTodoTitle = 'Added new Todo in Test';
      final newTodoDate = DateTime(2024, 01, 01);
      await todoCubit.addTodo(Todo(
        title: newTodoTitle,
        createdDate: newTodoDate,
      ));

      final newlyAddedTodo = todoCubit.state.todos
          .firstWhere((todo) => todo.title == newTodoTitle);

      // Checking if newTodo is added properly
      expect(newlyAddedTodo.title, newTodoTitle);
      expect(newlyAddedTodo.createdDate, newTodoDate);

      // Updating Todo
      final copiedTodo = newlyAddedTodo.copyWith();
      const updatedTodoTitle = 'Updated Todo';
      copiedTodo.title = updatedTodoTitle;
      await todoCubit.updateTodo(copiedTodo);

      // Checking if old todo is still exist after the update
      final oldTodo = todoCubit.state.todos.firstWhere(
        (todo) => todo.title == newTodoTitle,
        orElse: () => Todo(id: -1),
      );
      expect(oldTodo.id, -1);

      // Checking if the todo is updated properly
      final updatedTodo = todoCubit.state.todos
          .firstWhere((todo) => todo.title == updatedTodoTitle);
      expect(updatedTodoTitle, updatedTodo.title);

      // Deleting Todo
      await todoCubit.deleteTodo(updatedTodo.id);
      final deletedTodo = todoCubit.state.todos.firstWhere(
        (todo) => todo.title == updatedTodoTitle,
        orElse: () => Todo(id: -1),
      );
      expect(deletedTodo.id, -1);
    });
  });
}
