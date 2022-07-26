// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/details_page.dart';
import 'package:todo_app/util/app_keys.dart';
import 'package:todo_app/widgets/todo_item.dart';

import '../models/typedefs.dart';

class TodoList extends StatelessWidget {
  final List<Todo> filteredTodos;
  final bool loading;
  final TodoAdder addTodo;
  final TodoRemover removeTodo;
  final TodoUpdater updateTodo;

  const TodoList({
    required this.filteredTodos,
    required this.loading,
    required this.addTodo,
    required this.removeTodo,
    required this.updateTodo,
  }) : super(key: AppKeys.todoList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? const Center(
              child: CircularProgressIndicator(
              key: AppKeys.todosLoading,
            ))
          : ListView.builder(
              key: AppKeys.todoList,
              itemCount: filteredTodos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = filteredTodos[index];

                return TodoItem(
                  todo: todo,
                  onDismissed: (direction) {
                    _removeTodo(context, todo);
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return DetailPage(
                            todo: todo,
                            onDelete: () => _removeTodo(context, todo),
                            addTodo: addTodo,
                            updateTodo: updateTodo,
                          );
                        },
                      ),
                    );
                  },
                  onCheckboxChanged: (complete) {
                    updateTodo(todo, complete: !todo.complete);
                  },
                );
              },
            ),
    );
  }

  void _removeTodo(BuildContext context, Todo todo) {
    removeTodo(todo);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: AppKeys.snackbar,
        duration: const Duration(seconds: 2),
        content: Text(
          'Deleted "${todo.task}"',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            addTodo(todo);
          },
        ),
      ),
    );
  }
}
