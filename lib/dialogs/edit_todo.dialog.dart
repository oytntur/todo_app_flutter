import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.model.dart';

Future<TodoItem?> showEditTodoDialog(BuildContext context) async {
  final titleFormControl = TextEditingController();
  final subtitleFormControl = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Yeni Todo olustur'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleFormControl,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      labelText: 'Todo baslik', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: subtitleFormControl,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      labelText: 'Todo ek baslik',
                      border: OutlineInputBorder()),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final todoItem = TodoItem(
                        title: titleFormControl.text,
                        subtitle: subtitleFormControl.text);
                    Navigator.pop(context, todoItem);
                  },
                  child: const Text('Add Todo'))
            ],
          ));
}
