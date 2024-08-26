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
  var date = DateTime.now();
  var title = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Todo',
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
                  onChanged: (val) => title = val,
                ),
                const SizedBox(height: 16),
                const Text('Date'),
                const SizedBox(height: 4),
                DatePicker(
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
                  final todoCubit = TodoCubit(DependencyHelper.todoRepository);
                  await todoCubit.addTodo(Todo(
                    title: title,
                    createdDate: date,
                  ));
                  todoCubit.close();
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
}
