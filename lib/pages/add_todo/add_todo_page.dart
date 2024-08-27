import 'package:checklistapp/bloc/todo_cubit/todo_cubit.dart';
import 'package:checklistapp/components/date_picker.dart';
import 'package:checklistapp/components/g_navigation.dart';
import 'package:checklistapp/helper/dependency_helper.dart';
import 'package:checklistapp/helper/g_color.dart';
import 'package:checklistapp/models/entities/todo.entity.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  final Todo? todo;
  const AddTodoPage({this.todo, super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // var date =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var date = DateTime.now();
  late var title = widget.todo?.title ?? '';

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.todo != null;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isEdit ? 'Edit Todo' : 'Add Todo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text('Title'),
                const SizedBox(height: 4),
                TextFormField(
                  initialValue: title,
                  onChanged: (val) => title = val,
                ),
                const SizedBox(height: 16),
                const Text('Date'),
                const SizedBox(height: 4),
                DatePicker(
                  initialDate: widget.todo?.createdDate,
                  onPickedDate: (pickedDate) {
                    setState(() => date = pickedDate);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () async {
                  if (title.isEmpty) return;
                  if (isEdit) {
                    await updateTodo();
                  } else {
                    await addTodo();
                  }
                  GNavigation.pop();
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    GColor.scheme.primaryContainer,
                  ),
                ),
                child: Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateTodo() async {
    if (widget.todo == null) return;
    final todoCubit = TodoCubit(DependencyHelper.todoRepository);
    final updatedTodo = widget.todo!.copyWith(
      title: title,
      createdDate: date,
    );
    await todoCubit.updateTodo(updatedTodo);
    todoCubit.close();
  }

  Future<void> addTodo() async {
    final todoCubit = TodoCubit(DependencyHelper.todoRepository);
    await todoCubit.addTodo(Todo(
      title: title,
      createdDate: date,
    ));
    todoCubit.close();
  }
}
