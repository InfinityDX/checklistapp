part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final CubitStatus status;
  final List<Todo> todos;
  const TodoState({
    this.status = CubitStatus.initial,
    this.todos = const [],
  });

  TodoState copyWith({
    CubitStatus? status,
    List<Todo>? todos,
    Filter? filter,
    Meta? meta,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [status, todos];
}
