// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/pages/details_page.dart';
import 'package:todo_app/provider/todo_list_provider.dart';
import 'package:todo_app/util/app_keys.dart';
import 'package:todo_app/widgets/todo_item.dart';

import '../models/typedefs.dart';

class TodoList extends StatelessWidget {
  const TodoList() : super(key: AppKeys.todoList);

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoListProvider>();
    return Container(
      child: todoProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(
              key: AppKeys.todosLoading,
            ))
          : ListView.builder(
              key: AppKeys.todoList,
              itemCount: todoProvider.filteredTodos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = todoProvider.filteredTodos[index];

                return TodoItem(
                  todo: todo,
                  onDismissed: (direction) {
                    todoProvider.removeTodo(todo);
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
                    todoProvider
                        .updateTodo(todo.copyWith(complete: !todo.complete));
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
