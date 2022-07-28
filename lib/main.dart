import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/app_state.dart';
import 'package:todo_app/models/todo.dart';
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
  AppState appState = AppState.loading();

  @override
  void initState() {
    super.initState();

    widget.repository.loadTodos().then((loadedTodos) {
      setState(() {
        appState = AppState(
          todos: loadedTodos.toList(),
        );
      });
    }).catchError((err) {
      setState(() {
        appState.isLoading = false;
      });
    });
  }

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

  void toggleAll() {
    setState(() {
      appState.toggleAll();
    });
  }

  void clearCompleted() {
    setState(() {
      appState.clearCompleted();
    });
  }

  void addTodo(Todo todo) {
    setState(() {
      appState.todos.add(todo);
    });
  }

  void removeTodo(Todo todo) {
    setState(() {
      appState.todos.remove(todo);
    });
  }

  void updateTodo(
    Todo todo, {
    bool? complete,
    String? id,
    String? note,
    String? task,
  }) {
    setState(() {
      todo.complete = complete ?? todo.complete;
      todo.id = id ?? todo.id;
      todo.note = note ?? todo.note;
      todo.task = task ?? todo.task;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    widget.repository.saveTodos(
      appState.todos.toList(),
    );
  }
}
