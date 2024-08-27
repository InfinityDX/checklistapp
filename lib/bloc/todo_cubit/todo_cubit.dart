import 'dart:async';

import 'package:checklistapp/constants/cubit_state_enum.dart';
import 'package:checklistapp/helper/extensions/date_extensions.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/models/filter.dart';
import 'package:checklistapp/models/meta.dart';
import 'package:checklistapp/objectbox.g.dart';
import 'package:checklistapp/repository/interfaces/i_todo_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final ITodoRepository repository;
  final Filter filter;
  TodoCubit(this.repository, {this.filter = const Filter()})
      : super(const TodoState());

  @override
  Future<void> close() {
    todoSub?.cancel();
    return super.close();
  }

  Future<void> getTodos() async {
    if (state.status == CubitStatus.gettingData) return;
    emit(state.copyWith(status: CubitStatus.gettingData));

    final result = await repository.getTodos(filter: filter);
    watchTodo();

    emit(state.copyWith(
      status: CubitStatus.initial,
      todos: result,
    ));
  }

  StreamSubscription<Query<Todo>>? todoSub;

  Future<void> watchTodo() async {
    if (todoSub != null) return;

    final sub = await repository.watchTodo(filter: filter);
    todoSub = sub?.listen(_onTodoCollectionsChanged);
  }

  Future<void> _onTodoCollectionsChanged(Query<Todo> todoQuery) async {
    final result = await todoQuery.findAsync();
    emit(state.copyWith(todos: result));
  }

  Future<void> addTodo(Todo todo) async {
    if (state.status == CubitStatus.updating) return;
    emit(state.copyWith(status: CubitStatus.updating));

    var addedTodo = await repository.addTodo(todo);
    if (addedTodo != null) {
      final copiedTodo = List.of(state.todos);
      if (addedTodo.createdDate.isBetween(filter.startDate, filter.endDate)) {
        copiedTodo.add(addedTodo);
      }
      emit(state.copyWith(todos: copiedTodo));
      // Notify Success Popup
    } else {
      // Notify fail with message Popup
    }
    emit(state.copyWith(status: CubitStatus.initial));
  }

  Future<void> updateTodo(Todo todo) async {
    if (state.status == CubitStatus.updating) return;
    emit(state.copyWith(status: CubitStatus.updating));

    var updatedTodo = await repository.updateTodo(todo);
    if (updatedTodo != null) {
      final copiedTodo = List.of(state.todos);
      if (updatedTodo.createdDate.isBetween(filter.startDate, filter.endDate)) {
        final oldTodo = copiedTodo.firstWhere(
          (t) => t.id == todo.id,
          orElse: () => Todo(id: -1),
        );
        final indexOfOldTodo = copiedTodo.indexOf(oldTodo);
        copiedTodo[indexOfOldTodo] = updatedTodo;
      }
      emit(state.copyWith(todos: copiedTodo));

      // Notify Success Popup
    } else {
      // Notify fail with message Popup
    }
    emit(state.copyWith(status: CubitStatus.initial));
  }

  Future<void> deleteTodo(int id) async {
    if (state.status == CubitStatus.updating) return;
    emit(state.copyWith(status: CubitStatus.updating));

    var success = await repository.deleteTodo(id);
    if (success) {
      final copiedTodo = List.of(state.todos);
      copiedTodo.removeWhere((todo) => todo.id == id);
      emit(state.copyWith(todos: copiedTodo));
      // Notify Success Popup
    } else {
      // Notify fail with message Popup
    }
    emit(state.copyWith(status: CubitStatus.initial));
  }
}
