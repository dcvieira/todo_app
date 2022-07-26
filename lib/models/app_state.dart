import 'package:todo_app/models/todo.dart';

import 'enums.dart';

class AppState {
  bool isLoading;
  List<Todo> todos;

  AppState({
    this.isLoading = false,
    this.todos = const [],
  });

  factory AppState.loading() => AppState(isLoading: true);

  bool get allComplete => todos.every((todo) => todo.complete);

  List<Todo> filteredTodos(VisibilityFilter activeFilter) =>
      todos.where((todo) {
        switch (activeFilter) {
          case VisibilityFilter.active:
            return !todo.complete;
          case VisibilityFilter.completed:
            return todo.complete;
          case VisibilityFilter.all:
          default:
            return true;
        }
      }).toList();

  bool get hasCompletedTodos => todos.any((todo) => todo.complete);

  @override
  int get hashCode => todos.hashCode ^ isLoading.hashCode;

  int get numActive =>
      todos.fold(0, (sum, todo) => !todo.complete ? ++sum : sum);

  int get numCompleted =>
      todos.fold(0, (sum, todo) => todo.complete ? ++sum : sum);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          todos == other.todos &&
          isLoading == other.isLoading;

  void clearCompleted() {
    todos.removeWhere((todo) => todo.complete);
  }

  void toggleAll() {
    final allCompleted = allComplete;

    todos.forEach((todo) => todo.complete = !allCompleted);
  }

  @override
  String toString() {
    return 'AppState{todos: $todos, isLoading: $isLoading}';
  }
}
