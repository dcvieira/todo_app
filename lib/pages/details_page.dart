import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/typedefs.dart';
import 'package:todo_app/pages/add_edit_page.dart';
import 'package:todo_app/util/app_keys.dart';

class DetailPage extends StatelessWidget {
  final Todo todo;
  final Function onDelete;
  final TodoAdder addTodo;
  final TodoUpdater updateTodo;

  const DetailPage({
    required this.todo,
    required this.addTodo,
    required this.updateTodo,
    required this.onDelete,
  }) : super(key: AppKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Details'),
        actions: [
          IconButton(
            key: AppKeys.deleteTodoButton,
            tooltip: 'Delete Todo',
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Navigator.pop(context, todo);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: todo.complete,
                    key: AppKeys.detailsTodoItemCheckbox,
                    onChanged: (complete) {
                      updateTodo(todo, complete: !todo.complete);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          todo.task,
                          key: AppKeys.detailsTodoItemTask,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Text(
                        todo.note,
                        key: AppKeys.detailsTodoItemNote,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Delete Todo',
        key: AppKeys.editTodoFab,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddEditPage(
                  key: AppKeys.editTodoScreen,
                  updateTodo: updateTodo,
                  addTodo: addTodo,
                  todo: todo,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
