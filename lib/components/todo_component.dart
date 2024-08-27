import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/components/g_navigation.dart';
import 'package:checklistapp/helper/dependency_helper.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:checklistapp/pages/add_todo/add_todo_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    Theme.of(context);
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            padding: const EdgeInsets.all(0),
            backgroundColor: GColor.scheme.surface,
            autoClose: false,
            onPressed: onEditTodo,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: GColor.scheme.surfaceContainerHigh,
              ),
              width: 48,
              height: 48,
              child: Icon(
                FluentIcons.edit_24_filled,
                color: GColor.scheme.onSurface,
              ),
            ),
          ),
          CustomSlidableAction(
            padding: const EdgeInsets.all(0),
            backgroundColor: GColor.scheme.surface,
            foregroundColor: Colors.transparent,
            autoClose: false,
            onPressed: onDeleteTodo,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: GColor.scheme.errorContainer,
              ),
              width: 48,
              height: 48,
              child: Icon(
                FluentIcons.delete_20_filled,
                color: GColor.scheme.error,
              ),
            ),
          )
        ],
      ),
      child: Container(
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
                color: isCompleted
                    ? GColor.scheme.outline
                    : GColor.scheme.onSurface,
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

  void onDeleteTodo(BuildContext context) async {
    if (widget.todo == null) return;
    final isOk = await showAdaptiveDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text('Do you want to delete this task?'),
          actions: [
            adaptiveAction(
              context: context,
              onPressed: () => GNavigation.pop(
                context: context,
                arg: false,
              ),
              child: Text('Cancel'),
            ),
            adaptiveAction(
              context: context,
              onPressed: () => GNavigation.pop(
                context: context,
                arg: true,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (isOk ?? false) {
      final todoCubit = TodoCubit(DependencyHelper.todoRepository);
      await todoCubit.deleteTodo(widget.todo!.id);
      todoCubit.close();
    }
  }

  void onEditTodo(BuildContext context) async {
    if (widget.todo == null) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddTodoPage(todo: widget.todo);
      },
    );
  }

  Widget adaptiveAction(
      {required BuildContext context,
      required VoidCallback onPressed,
      required Widget child}) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
        return TextButton(onPressed: onPressed, child: child);
      case TargetPlatform.iOS:
        return CupertinoDialogAction(onPressed: onPressed, child: child);
      default:
        return TextButton(onPressed: onPressed, child: child);
    }
  }
}
