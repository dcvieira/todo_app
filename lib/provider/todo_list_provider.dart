import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/todo.dart';

class TodoListProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get numActive =>
      todos.where((Todo todo) => !todo.complete).toList().length;

  int get numCompleted => 0;

  // Actions
  void completeAll() {
    _todos = _todos.map((todo) => todo.copyWith(complete: true)).toList();
  }

  void clearCompleted() {
    _todos.removeWhere((todo) => todo.complete);
  }

  void addTodo(Todo todo) {
    // Cadastrar Todo
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((it) => it.id == todo.id);
  }

  void updateTodo(Todo todo) {
    var oldTodo = _todos.firstWhere((it) => it.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
  }
}
