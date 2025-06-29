import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/dialogs/edit_todo.dialog.dart';
import 'package:todo_app/models/todo.model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TodoItem> todos = [
    TodoItem(title: 'Yeni is', subtitle: 'is detayi'),
    TodoItem(title: 'Yeni is2', subtitle: 'is detayi2'),
    TodoItem(title: 'Yeni is3', subtitle: 'is detayi3'),
    TodoItem(title: 'Yeni is4', subtitle: 'is detayi4'),
    TodoItem(title: 'Yeni is5', subtitle: 'is detayi5'),
  ];

  void _editTodo(TodoItem? editingTodo) async {
    if (editingTodo == null) {
      final TodoItem? newTodo = await showEditTodoDialog(context);

      if (newTodo != null) {
        setState(() {
          todos.add(newTodo);
        });
      }
    } else {
      final updatedTodo =
          await showEditTodoDialog(context, todoItem: editingTodo);
      //find and replace the todo in the list

      if (updatedTodo == null) return;

      setState(() {
        final index = todos.indexWhere((todo) => todo.uuid == updatedTodo.uuid);
        if (index != -1) {
          print('before: ${todos[index]}');
          todos[index] = updatedTodo;
          print('after: ${todos[index]}');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoList = ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return MyListItem(
            todoItem: todo, onTap: _editTodo // Use uuid or title as key
            );
      },
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: todoList,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _editTodo(null),
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyListItem extends StatelessWidget {
  final TodoItem todoItem;
  final void Function(TodoItem) onTap;

  const MyListItem({
    super.key,
    required this.todoItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todoItem.title),
      subtitle: Text(todoItem.subtitle),
      leading: const Icon(Icons.label),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => onTap(todoItem),
    );
  }
}
