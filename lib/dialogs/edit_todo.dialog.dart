import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.model.dart';

Future<TodoItem?> showEditTodoDialog(BuildContext context,
    {TodoItem? todoItem}) async {
  final titleFormControl = TextEditingController(text: todoItem?.title ?? '');
  final subtitleFormControl =
      TextEditingController(text: todoItem?.subtitle ?? '');

  final isEdit = todoItem != null;

  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(isEdit ? 'Todo Duzenle' : 'Todo ekle'),
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
                    final returningTodoItem = TodoItem(
                        uuid: todoItem?.uuid,
                        title: titleFormControl.text,
                        subtitle: subtitleFormControl.text);
                    returningTodoItem.addOrUpdateTodo();
                    Navigator.pop(context, returningTodoItem);
                  },
                  child: Text(isEdit ? 'Edit Todo' : 'Add Todo'))
            ],
          ));
}
