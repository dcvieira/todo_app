import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/enums.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/repository/todos_repository.dart';

class TodoListProvider extends ChangeNotifier {
  final TodosRepository repository;
  List<Todo> _todos = [];
  bool _isLoading = false;
  VisibilityFilter _filter = VisibilityFilter.all;

  TodoListProvider({required this.repository});

  // Getters
  bool get isLoading => _isLoading;

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  bool get allComplete => todos.every((todo) => todo.complete);

  bool get hasCompletedTodos => todos.any((todo) => todo.complete);

  VisibilityFilter get filter => _filter;

  int get numActive =>
      todos.where((Todo todo) => !todo.complete).toList().length;

  int get numCompleted =>
      todos.where((Todo todo) => todo.complete).toList().length;

  List<Todo> get filteredTodos {
    return _todos.where((todo) {
      switch (filter) {
        case VisibilityFilter.active:
          return !todo.complete;
        case VisibilityFilter.completed:
          return todo.complete;
        case VisibilityFilter.all:
        default:
          return true;
      }
    }).toList();
  }

  Todo? todoById(String id) {
    final todos = _todos.where((it) => it.id == id);
    if (todos.isNotEmpty) {
      return todos.elementAt(0);
    }
    return null;
  }

  // Setter
  set filter(VisibilityFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  // Actions
  void toggleAll() {
    var allComplete = todos.every((todo) => todo.complete);
    _todos =
        _todos.map((todo) => todo.copyWith(complete: !allComplete)).toList();
    notifyListeners();
    _saveTodos();
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.complete);
    notifyListeners();
    _saveTodos();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
    _saveTodos();
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((it) => it.id == todo.id);
    notifyListeners();
    _saveTodos();
  }

  void updateTodo(Todo todo) {
    var oldTodo = _todos.firstWhere((it) => it.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
    notifyListeners();
    _saveTodos();
  }

  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();
    final todos = await repository.loadTodos();
    _todos.addAll(todos);
    _isLoading = false;
    notifyListeners();
  }

  void _saveTodos() {
    repository.saveTodos(_todos);
  }
}
