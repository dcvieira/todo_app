import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/add_edit_page.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/provider/todo_list_provider.dart';
import 'package:todo_app/repository/local_storage_repository.dart';
import 'package:todo_app/repository/todos_repository.dart';
import 'package:todo_app/theme/todo_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoApp(repository: LocalStorageRepository()));
}

class TodoApp extends StatefulWidget {
  final TodosRepository repository;

  const TodoApp({Key? key, required this.repository}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          TodoListProvider(repository: widget.repository)..loadTodos(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: TodoAppTheme.theme,
        routes: {
          "/": (context) => const HomePage(),
          '/addTodo': (context) => const AddEditPage()
        },
      ),
    );
  }
}
