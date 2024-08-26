import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/helper/dependency_helper.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class TodoComponent extends StatefulWidget {
  final Todo? todo;
  const TodoComponent({this.todo, super.key});

  @override
  State<TodoComponent> createState() => _TodoComponentState();
}

class _TodoComponentState extends State<TodoComponent> {
  late var isCompleted = widget.todo?.isCompleted ?? false;
  late var isPriority = widget.todo?.isPrioritized ?? false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isPriority
            ? GColor.scheme.errorContainer
            : GColor.scheme.surfaceContainer,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() => isCompleted = !isCompleted);
              updateTodo();
            },
            child: Icon(
              isCompleted
                  ? FluentIcons.checkmark_circle_24_filled
                  : FluentIcons.circle_24_regular,
              color:
                  isCompleted ? GColor.scheme.outline : GColor.scheme.onSurface,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.todo?.title ?? '--',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                decorationThickness: 4,
                color: isCompleted
                    ? GColor.scheme.outline
                    : GColor.scheme.onSurface,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                decorationColor: GColor.scheme.outline,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isCompleted) return;
              setState(() => isPriority = !isPriority);
              updateTodo();
            },
            child: Icon(
              isPriority
                  ? FluentIcons.star_24_filled
                  : FluentIcons.star_24_regular,
              color: isPriority ? GColor.scheme.error : GColor.scheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  void updateTodo() async {
    final todoCubit = TodoCubit(DependencyHelper.todoRepository);
    final updatedTodo = widget.todo
        ?.copyWith(isCompleted: isCompleted, isPrioritized: isPriority);

    if (updatedTodo == null) return;
    await todoCubit.updateTodo(updatedTodo);
    todoCubit.close();
  }
}
